class Class
  # Defines class-level inheritable array accessors as specified in fields. Fields can be one or more
  # symbols specifying the names of the accessors.
  #
  # Consider an inheritable array accessor :acc defined in class Base and a class Derived, inheriting
  # from class Base.
  #
  #   0. :acc is never set. Then Base.acc and Derived.acc are both empty []
  #   1. :acc is set in class Base. Then Base.acc and Derived.acc both contain the same elements
  #   2. :acc is set in class Derived. Then Base.acc is empty [] and Derived.acc is not
  #   3. :acc is set in both Base and Derived, but with different values. Then Base.acc returns the set
  #      value(s) and Derived.acc returns an array containing both the values set to Base.acc as well as
  #      the values set to Derived.acc, in that order.
  #
  # Inheritable array setters accept both single values or arrays. When setters are used, they overwrite
  # any previously set values for this class within the hierarchy (and therefore influencing any subclasses),
  # but do not modify any base classes.
  def class_inheritable_array(*fields)
    fields.each do |field|
      metaclass.send :define_method, field do
        array = instance_variable_get("@#{field}") || []
        super_array = (superclass.send(field) if superclass.respond_to?(field)) || []
        [super_array, array].flatten
      end
    end
    
    cattr_writer *fields
  end
end
