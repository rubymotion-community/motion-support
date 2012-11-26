class Object
  # Returns an object's metaclass.
  def metaclass
    class << self
      self
    end
  end
end
