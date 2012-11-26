class Class
  # Defines class-level inheritable accessors as specified in fields. Fields can be one or more
  # symbols specifying the names of the accessors.
  #
  # The inheritance semantics of inheritable accessors are similar to methods. Consider an inheritable
  # accessor :acc defined in class Base and a class Derived, inheriting from class Base.
  #
  #   0. :acc is never set. Then Base.acc and Derived.acc are both nil
  #   1. :acc is set in class Base. Then Base.acc and Derived.acc are equal
  #   2. :acc is set in class Derived. Then Base.acc is nil and Derived.acc is set
  #   3. :acc is set in both Base and Derived, but to different values. Then Base.acc and Derived.acc
  #      have their respective set values.
  def class_inheritable_accessor(*fields)
    fields.each do |field|
      metaclass.send :define_method, field do
        ivar = instance_variable_get("@#{field}")
        ivar || (superclass.send(field) if superclass.respond_to?(field))
      end
    end
    
    cattr_writer *fields
  end
end
