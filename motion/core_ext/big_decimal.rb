class BigDecimal

  # Returns an exact copy of self
  def dup
    self.class.new(self)
  end

end
