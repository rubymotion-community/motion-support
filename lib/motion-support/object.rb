class Object
  # True for objects that are considered blank or empty, such as nil, empty string, empty array
  # or the empty hash. When the object responds to empty?, then blank? delegates to empty?,
  # otherwise it returns false, except for nil.
  def blank?
    if respond_to?(:empty?)
      empty?
    else
      false
    end
  end
  
  # Opposite of blank?
  def present?
    !blank?
  end
end
