motion_require "module/delegation"

class NSDictionary
  def to_hash
    Hash.new.tap do |h|
      h.replace self
    end
  end
  
  delegate :symbolize_keys, :to => :to_hash
end
