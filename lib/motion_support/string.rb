class String
  # Returns a pluralized version of the string, if it is not already pluralized. This implementation
  # is rather naive, as it only appends an 's' to the string, unless it already ends with 's'.
  def pluralize
    if self[-1] == 's'
      self
    else
      self + "s"
    end
  end

  # Returns a singularized version of the string, if it is not already pluralized. This implementation
  # is rather naive, as it only removes a trailing 's' from the string, unless it does not end in 's'.
  def singularize
    if self[-1] == 's'
      self[0..-2]
    else
      self
    end
  end
  
  # This method makes a string look like a class name. This means an under_scored string will become
  # a CamelizedString, also it will be singularized, if it is plural.
  def classify
    singularize.camelize
  end
end
