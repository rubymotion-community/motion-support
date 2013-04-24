class Time
  def to_date
    Date.new(year, month, day)
  end
  
  def to_time
    self
  end
  
  def ==(other)
    other &&
    year == other.year &&
    month == other.month &&
    day == other.day &&
    hour == other.hour &&
    min == other.min &&
    sec == other.sec
  end
end
