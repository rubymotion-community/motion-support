motion_require "module/delegation"

class NSDictionary
  def to_hash
    Hash.new(self)
  end
  
  delegate :symbolize_keys, :to => :to_hash
end

class Hash
  def empty?
    self.length < 1
  end

  # Returns the contents of the hash, with the exception
  # of the keys specified in the keys array.
  def except(*keys)
    self.dup.reject{|k, v| keys.include?(k)}
  end
end
