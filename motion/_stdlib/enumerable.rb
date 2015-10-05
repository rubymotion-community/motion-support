module Enumerable
  def reverse_each(&block)
    return to_enum(:reverse_each) unless block_given?

    # There is no other way then to convert to an array first... see 1.9's source.
    to_a.reverse_each(&block)
    self
  end

  def to_hash
    hash = Hash.new
    each do |key, value|
      hash[key] = value
    end
    hash
  end

  alias_method :to_h, :to_hash
end
