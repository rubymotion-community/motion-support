class Array
  def reverse_each
    return to_enum(:reverse_each) unless block_given?

    i = size - 1
    while i >= 0
      yield self[i]
      i -= 1
    end
    
    self
  end
end
