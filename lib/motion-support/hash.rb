class NSDictionary
  # Returns a new Hash which is a copy of this hash, except that all keys have turned into symbols,
  # if possible. That is all keys that respond to to_sym.
  def symbolize_keys
    inject({}) do |hash, pair|
      if pair.first.respond_to?(:to_sym)
        hash[pair.first.to_sym] = pair.last
      else
        hash[pair.first] = pair.last
      end
      hash
    end
  end
end

class Hash
  # Changes all keys in this hash into symbols, if possible. That is all keys that respond to to_sym.
  def symbolize_keys!
    replace(symbolize_keys)
  end

  def empty?
    self.length < 1
  end

  # Returns the contents of the hash, with the exception
  # of the keys specified in the keys array.
  def except(*keys)
    self.dup.reject{|k, v| keys.include?(k)}
  end
end
