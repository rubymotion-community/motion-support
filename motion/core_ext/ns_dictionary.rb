motion_require "module/delegation"

class NSDictionary
  def to_hash
    Hash.new.tap do |h|
      h.replace self
    end
  end
  
  delegate :symbolize_keys, :with_indifferent_access, :nested_under_indifferent_access, :to => :to_hash
end
