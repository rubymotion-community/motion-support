class Array
  # Returns the tail of the array from +position+.
  def from(position)
    self[position, length] || []
  end

  # Returns the beginning of the array up to +position+.
  def to(position)
    first position + 1
  end

  # Returns the second element in an array if it exists, otherwise nil.
  def second
    self[1]
  end
end
