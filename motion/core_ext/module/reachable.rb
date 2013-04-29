class Module
  def reachable? #:nodoc:
    !anonymous? && name.safe_constantize.equal?(self)
  end
end
