class Date
  def self.gregorian_leap?(year)
    if year % 400 == 0
      true
    elsif year % 100 == 0 then
      false
    elsif year % 4 == 0 then
      true
    else
      false
    end
  end
  
  def initialize(year = nil, month = nil, day = nil)
    if year && month && day
      @value = Time.utc(year, month, day)
    else
      @value = Time.now
    end
  end
  
  def self.today
    new
  end
  
  def inspect
    "#{year}-#{month}-#{day}"
  end
  
  def ==(other)
    year == other.year &&
    month == other.month &&
    day == other.day
  end
  
  def +(other)
    val = @value + other * 3600 * 24
    Date.new(val.year, val.month, val.day)
  end
  
  def -(other)
    if other.is_a?(Date)
      (@value - other.instance_variable_get(:@value)) / (3600 * 24)
    elsif other.is_a?(Time)
      (@value - other) 
    else
      self + (-other)
    end
  end
  
  def >>(months)
    new_year = year + (self.month + months - 1) / 12
    new_month = (self.month + months) % 12
    new_month = new_month == 0 ? 12 : new_month
    new_day = [day, Time.days_in_month(new_month, new_year)].min
    
    Date.new(new_year, new_month, new_day)
  end
  
  def <<(months)
    return self >> -months
  end
  
  [:year, :month, :day, :wday, :<, :<=, :>, :>=, :"<=>"].each do |method|
    define_method method do |*args|
      @value.send(method, *args)
    end
  end
  
  def to_date
    self
  end
  
  def to_time
    @value
  end
end
