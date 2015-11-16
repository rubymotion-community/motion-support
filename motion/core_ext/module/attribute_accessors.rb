class Module
  def mattr_reader(*syms)
    receiver = self
    options = syms.extract_options!
    syms.each do |sym|
      raise NameError.new("invalid attribute name") unless sym =~ /^[_A-Za-z]\w*$/
      class_exec do
        unless class_variable_defined?("@@#{sym}")
          class_variable_set("@@#{sym}", nil)
        end

        define_singleton_method sym do
          class_variable_get("@@#{sym}")
        end
      end

      next if options[:instance_reader] == false ||
          options[:instance_accessor] == false

      class_exec do
        define_method sym do
          receiver.class_variable_get("@@#{sym}")
        end
      end
    end
  end

  def mattr_writer(*syms)
    receiver = self
    options = syms.extract_options!
    syms.each do |sym|
      raise NameError.new("invalid attribute name") unless sym =~ /^[_A-Za-z]\w*$/
      class_exec do
        define_singleton_method "#{sym}=" do |obj|
          class_variable_set("@@#{sym}", obj)
        end
      end

      next if options[:instance_writer] == false ||
          options[:instance_accessor] == false

      class_exec do
        define_method "#{sym}=" do |obj|
          receiver.class_variable_set("@@#{sym}", obj)
        end
      end
    end
  end

  # Extends the module object with module and instance accessors for class attributes,
  # just like the native attr* accessors for instance attributes.
  #
  #   module AppConfiguration
  #     mattr_accessor :google_api_key
  #
  #     self.google_api_key = "123456789"
  #   end
  #
  #   AppConfiguration.google_api_key # => "123456789"
  #   AppConfiguration.google_api_key = "overriding the api key!"
  #   AppConfiguration.google_api_key # => "overriding the api key!"
  def mattr_accessor(*syms)
    mattr_reader(*syms)
    mattr_writer(*syms)
  end
end
