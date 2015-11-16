class Date
  def self.gregorian_leap?(year)
    if year % 400 == 0
      true
    elsif year % 100 == 0
      false
    elsif year % 4 == 0
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

  def to_s
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

  def >>(other)
    new_year = year + (month + other - 1) / 12
    new_month = (month + other) % 12
    new_month = new_month == 0 ? 12 : new_month
    new_day = [day, Time.days_in_month(new_month, new_year)].min

    Date.new(new_year, new_month, new_day)
  end

  def <<(other)
    self >> -other
  end

  [:year, :month, :day, :wday, :<, :<=, :>, :>=, :"<=>", :strftime].each do |method|
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

  def succ
    self + 1
  end
end
