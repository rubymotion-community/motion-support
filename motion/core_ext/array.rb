class Array
  # If any item in the array has the key == `key` true, otherwise false.
  # Of good use when writing specs.
  def has_hash_key?(key)
    each do |entity|
      return true if entity.key? key
    end
    false
  end

  # If any item in the array has the value == `key` true, otherwise false
  # Of good use when writing specs.
  def has_hash_value?(key)
    each do |entity|
      entity.each_pair { |_hash_key, value| return true if value == key }
    end
    false
  end
end
