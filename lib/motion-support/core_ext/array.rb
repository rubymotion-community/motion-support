class Array
  def empty?
    self.length < 1
  end

  # If any item in the array has the key == `key` true, otherwise false.
  # Of good use when writing specs.
  def has_hash_key?(key)
    self.each do |entity|
      return true if entity.has_key? key
    end
    return false
  end

  # If any item in the array has the value == `key` true, otherwise false
  # Of good use when writing specs.
  def has_hash_value?(key)
    self.each do |entity|
      entity.each_pair{|hash_key, value| return true if value == key}
    end
    return false
  end
end
