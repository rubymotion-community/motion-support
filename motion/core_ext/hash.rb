motion_require "module/delegation"

class NSDictionary
  def to_hash
    Hash.new(self)
  end
  
  delegate :symbolize_keys, :to => :to_hash
end
