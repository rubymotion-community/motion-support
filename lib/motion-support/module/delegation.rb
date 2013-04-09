class Module
  # Provides a delegate class method to easily expose contained objects' public methods
  # as your own. Pass one or more methods (specified as symbols or strings)
  # and the name of the target object via the <tt>:to</tt> option (also a symbol
  # or string). At least one method and the <tt>:to</tt> option are required.
  #
  # Delegation is particularly useful with Active Record associations:
  #
  #   class Greeter < ActiveRecord::Base
  #     def hello
  #       'hello'
  #     end
  #
  #     def goodbye
  #       'goodbye'
  #     end
  #   end
  #
  #   class Foo < ActiveRecord::Base
  #     belongs_to :greeter
  #     delegate :hello, to: :greeter
  #   end
  #
  #   Foo.new.hello   # => "hello"
  #   Foo.new.goodbye # => NoMethodError: undefined method `goodbye' for #<Foo:0x1af30c>
  #
  # Multiple delegates to the same target are allowed:
  #
  #   class Foo < ActiveRecord::Base
  #     belongs_to :greeter
  #     delegate :hello, :goodbye, to: :greeter
  #   end
  #
  #   Foo.new.goodbye # => "goodbye"
  #
  # Methods can be delegated to instance variables, class variables, or constants
  # by providing them as a symbols:
  #
  #   class Foo
  #     CONSTANT_ARRAY = [0,1,2,3]
  #     @@class_array  = [4,5,6,7]
  #
  #     def initialize
  #       @instance_array = [8,9,10,11]
  #     end
  #     delegate :sum, to: :CONSTANT_ARRAY
  #     delegate :min, to: :@@class_array
  #     delegate :max, to: :@instance_array
  #   end
  #
  #   Foo.new.sum # => 6
  #   Foo.new.min # => 4
  #   Foo.new.max # => 11
  #
  # It's also possible to delegate a method to the class by using +:class+:
  #
  #   class Foo
  #     def self.hello
  #       "world"
  #     end
  #
  #     delegate :hello, to: :class
  #   end
  #
  #   Foo.new.hello # => "world"
  #
  # Delegates can optionally be prefixed using the <tt>:prefix</tt> option. If the value
  # is <tt>true</tt>, the delegate methods are prefixed with the name of the object being
  # delegated to.
  #
  #   Person = Struct.new(:name, :address)
  #
  #   class Invoice < Struct.new(:client)
  #     delegate :name, :address, to: :client, prefix: true
  #   end
  #
  #   john_doe = Person.new('John Doe', 'Vimmersvej 13')
  #   invoice = Invoice.new(john_doe)
  #   invoice.client_name    # => "John Doe"
  #   invoice.client_address # => "Vimmersvej 13"
  #
  # It is also possible to supply a custom prefix.
  #
  #   class Invoice < Struct.new(:client)
  #     delegate :name, :address, to: :client, prefix: :customer
  #   end
  #
  #   invoice = Invoice.new(john_doe)
  #   invoice.customer_name    # => 'John Doe'
  #   invoice.customer_address # => 'Vimmersvej 13'
  #
  # If the delegate object is +nil+ an exception is raised, and that happens
  # no matter whether +nil+ responds to the delegated method. You can get a
  # +nil+ instead with the +:allow_nil+ option.
  #
  #   class Foo
  #     attr_accessor :bar
  #     def initialize(bar = nil)
  #       @bar = bar
  #     end
  #     delegate :zoo, to: :bar
  #   end
  #
  #   Foo.new.zoo   # raises NoMethodError exception (you called nil.zoo)
  #
  #   class Foo
  #     attr_accessor :bar
  #     def initialize(bar = nil)
  #       @bar = bar
  #     end
  #     delegate :zoo, to: :bar, allow_nil: true
  #   end
  #
  #   Foo.new.zoo   # returns nil
  def delegate(*methods)
    options = methods.pop
    unless options.is_a?(Hash) && to = options[:to]
      raise ArgumentError, 'Delegation needs a target. Supply an options hash with a :to key as the last argument (e.g. delegate :hello, to: :greeter).'
    end

    prefix, allow_nil = options.values_at(:prefix, :allow_nil)
    unguarded = !allow_nil

    if prefix == true && to =~ /^[^a-z_]/
      raise ArgumentError, 'Can only automatically set the delegation prefix when delegating to a method.'
    end

    method_prefix = \
      if prefix
        "#{prefix == true ? to : prefix}_"
      else
        ''
      end

    reference, *hierarchy = to.to_s.split('.')
    entry = resolver =
      case reference
      when 'self'
        ->(_self) { _self }
      when /^@@/
        ->(_self) { _self.class.class_variable_get(reference) }
      when /^@/
        ->(_self) { _self.instance_variable_get(reference) }
      when /^[A-Z]/
        ->(_self) { if reference.to_s =~ /::/ then reference.constantize else _self.class.const_get(reference) end }
      else
        ->(_self) { _self.send(reference) }
      end
    resolver = ->(_self) { hierarchy.reduce(entry.call(_self)) { |obj, method| obj.public_send(method) } } unless hierarchy.empty?

    methods.each do |method|
      module_exec do
        # def customer_name(*args, &block)
        #   begin
        #     if unguarded || client || client.respond_to?(:name)
        #       client.name(*args, &block)
        #     end
        #   rescue client.nil? && NoMethodError
        #     raise "..."
        #   end
        # end
        define_method("#{method_prefix}#{method}") do |*args, &block|
          target = resolver.call(self)
          if unguarded || target || target.respond_to?(method)
            begin
              target.public_send(method, *args, &block)
            rescue target.nil? && NoMethodError # only rescue NoMethodError when target is nil
              raise "#{self}##{method_prefix}#{method} delegated to #{to}.#{method}, but #{to} is nil: #{self.inspect}"
            end
          end
        end
      end
    end
  end
end
