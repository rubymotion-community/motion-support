require_relative '../date_and_time/calculations'

class Time
  include DateAndTime::Calculations

  COMMON_YEAR_DAYS_IN_MONTH = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

  class << self
    # Return the number of days in the given month.
    # If no year is specified, it will use the current year.
    def days_in_month(month, year = now.year)
      if month == 2 && ::Date.gregorian_leap?(year)
        29
      else
        COMMON_YEAR_DAYS_IN_MONTH[month]
      end
    end

    # Alias for <tt>Time.now</tt>.
    def current
      ::Time.now
    end
  end

  # Seconds since midnight: Time.now.seconds_since_midnight
  def seconds_since_midnight
    to_i - change(:hour => 0).to_i + (usec / 1.0e+6)
  end

  # Returns the number of seconds until 23:59:59.
  #
  #   Time.new(2012, 8, 29,  0,  0,  0).seconds_until_end_of_day # => 86399
  #   Time.new(2012, 8, 29, 12, 34, 56).seconds_until_end_of_day # => 41103
  #   Time.new(2012, 8, 29, 23, 59, 59).seconds_until_end_of_day # => 0
  def seconds_until_end_of_day
    end_of_day.to_i - to_i
  end

  # Returns a new Time where one or more of the elements have been changed according
  # to the +options+ parameter. The time options (<tt>:hour</tt>, <tt>:min</tt>,
  # <tt>:sec</tt>, <tt>:usec</tt>) reset cascadingly, so if only the hour is passed,
  # then minute, sec, and usec is set to 0. If the hour and minute is passed, then
  # sec and usec is set to 0.  The +options+ parameter takes a hash with any of these
  # keys: <tt>:year</tt>, <tt>:month</tt>, <tt>:day</tt>, <tt>:hour</tt>, <tt>:min</tt>,
  # <tt>:sec</tt>, <tt>:usec</tt>.
  #
  #   Time.new(2012, 8, 29, 22, 35, 0).change(day: 1)              # => Time.new(2012, 8, 1, 22, 35, 0)
  #   Time.new(2012, 8, 29, 22, 35, 0).change(year: 1981, day: 1)  # => Time.new(1981, 8, 1, 22, 35, 0)
  #   Time.new(2012, 8, 29, 22, 35, 0).change(year: 1981, hour: 0) # => Time.new(1981, 8, 29, 0, 0, 0)
  def change(options)
    new_year  = options.fetch(:year, year)
    new_month = options.fetch(:month, month)
    new_day   = options.fetch(:day, day)
    new_hour  = options.fetch(:hour, hour)
    new_min   = options.fetch(:min, options[:hour] ? 0 : min)
    new_sec   = options.fetch(:sec, (options[:hour] || options[:min]) ? 0 : sec)
    new_usec  = options.fetch(:usec, (options[:hour] || options[:min] || options[:sec]) ? 0 : Rational(nsec, 1000))

    if utc?
      ::Time.utc(new_year, new_month, new_day, new_hour, new_min, new_sec, new_usec)
    elsif zone
      ::Time.local(new_year, new_month, new_day, new_hour, new_min, new_sec, new_usec)
    else
      ::Time.new(new_year, new_month, new_day, new_hour, new_min, new_sec + (new_usec.to_r / 1000000), utc_offset)
    end
  end

  # Uses Date to provide precise Time calculations for years, months, and days.
  # The +options+ parameter takes a hash with any of these keys: <tt>:years</tt>,
  # <tt>:months</tt>, <tt>:weeks</tt>, <tt>:days</tt>, <tt>:hours</tt>,
  # <tt>:minutes</tt>, <tt>:seconds</tt>.
  def advance(options)
    unless options[:weeks].nil?
      options[:weeks], partial_weeks = options[:weeks].divmod(1)
      options[:days] = options.fetch(:days, 0) + 7 * partial_weeks
    end

    unless options[:days].nil?
      options[:days], partial_days = options[:days].divmod(1)
      options[:hours] = options.fetch(:hours, 0) + 24 * partial_days
    end

    d = to_date.advance(options)
    time_advanced_by_date = change(:year => d.year, :month => d.month, :day => d.day)
    seconds_to_advance = \
      options.fetch(:seconds, 0) +
      options.fetch(:minutes, 0) * 60 +
      options.fetch(:hours, 0) * 3600

    if seconds_to_advance.zero?
      time_advanced_by_date
    else
      time_advanced_by_date.since(seconds_to_advance)
    end
  end

  # Returns a new Time representing the time a number of seconds ago, this is basically a wrapper around the Numeric extension
  def ago(seconds)
    since(-seconds)
  end

  # Returns a new Time representing the time a number of seconds since the instance time
  def since(seconds)
    self + seconds
  rescue
    to_datetime.since(seconds)
  end
  alias :in :since

  # Returns a new Time representing the start of the day (0:00)
  def beginning_of_day
    #(self - seconds_since_midnight).change(usec: 0)
    change(:hour => 0)
  end
  alias :midnight :beginning_of_day
  alias :at_midnight :beginning_of_day
  alias :at_beginning_of_day :beginning_of_day

  # Returns a new Time representing the end of the day, 23:59:59.999999 (.999999999 in ruby1.9)
  def end_of_day
    change(
      :hour => 23,
      :min => 59,
      :sec => 59,
      :usec => Rational(999999999, 1000)
    )
  end
  alias :at_end_of_day :end_of_day

  # Returns a new Time representing the start of the hour (x:00)
  def beginning_of_hour
    change(:min => 0)
  end
  alias :at_beginning_of_hour :beginning_of_hour

  # Returns a new Time representing the end of the hour, x:59:59.999999 (.999999999 in ruby1.9)
  def end_of_hour
    change(
      :min => 59,
      :sec => 59,
      :usec => Rational(999999999, 1000)
    )
  end
  alias :at_end_of_hour :end_of_hour

  # Returns a new Time representing the start of the minute (x:xx:00)
  def beginning_of_minute
    change(:sec => 0)
  end
  alias :at_beginning_of_minute :beginning_of_minute

  # Returns a new Time representing the end of the minute, x:xx:59.999999 (.999999999 in ruby1.9)
  def end_of_minute
    change(
      :sec => 59,
      :usec => Rational(999999999, 1000)
    )
  end
  alias :at_end_of_minute :end_of_minute

  # Returns a Range representing the whole day of the current time.
  def all_day
    beginning_of_day..end_of_day
  end

  # Returns a Range representing the whole week of the current time.
  # Week starts on start_day, default is <tt>Date.week_start</tt> or <tt>config.week_start</tt> when set.
  def all_week(start_day = Date.beginning_of_week)
    beginning_of_week(start_day)..end_of_week(start_day)
  end

  # Returns a Range representing the whole month of the current time.
  def all_month
    beginning_of_month..end_of_month
  end

  # Returns a Range representing the whole quarter of the current time.
  def all_quarter
    beginning_of_quarter..end_of_quarter
  end

  # Returns a Range representing the whole year of the current time.
  def all_year
    beginning_of_year..end_of_year
  end

  def plus_with_duration(other) #:nodoc:
    if MotionSupport::Duration === other
      other.since(self)
    else
      plus_without_duration(other)
    end
  end
  alias_method :plus_without_duration, :+
  alias_method :+, :plus_with_duration

  def minus_with_duration(other) #:nodoc:
    if MotionSupport::Duration === other
      other.until(self)
    else
      minus_without_duration(other)
    end
  end
  alias_method :minus_without_duration, :-
  alias_method :-, :minus_with_duration

  # Layers additional behavior on Time#<=> so that Date instances
  # can be chronologically compared with a Time
  def compare_with_coercion(other)
    compare_without_coercion(other.to_time)
  end
  alias_method :compare_without_coercion, :<=>
  alias_method :<=>, :compare_with_coercion

end
