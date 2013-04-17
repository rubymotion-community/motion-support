class Array
  # Extracts options from a set of arguments. Removes and returns the last
  # element in the array if it's a hash, otherwise returns a blank hash.
  def extract_options!
    if last.is_a?(Hash)
      pop
    else
      {}
    end
  end
end
