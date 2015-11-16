class Time
  DATE_FORMATS = {
    :db           => "%Y-%m-%d %H:%M:%S",
    :number       => "%Y%m%d%H%M%S",
    :nsec         => "%Y%m%d%H%M%S%9N",
    :time         => "%H:%M",
    :short        => "%d %b %H:%M",
    :long         => "%B %d, %Y %H:%M",
    :long_ordinal => lambda do |time|
      day_format = MotionSupport::Inflector.ordinalize(time.day)
      time.strftime("%B #{day_format}, %Y %H:%M")
    end,
    :rfc822 => lambda do |time|
      offset_format = time.formatted_offset(false)
      time.strftime("%a, %d %b %Y %H:%M:%S #{offset_format}")
    end
  }

  # Converts to a formatted string. See DATE_FORMATS for builtin formats.
  #
  # This method is aliased to <tt>to_s</tt>.
  #
  #   time = Time.now                    # => Thu Jan 18 06:10:17 CST 2007
  #
  #   time.to_formatted_s(:time)         # => "06:10"
  #   time.to_s(:time)                   # => "06:10"
  #
  #   time.to_formatted_s(:db)           # => "2007-01-18 06:10:17"
  #   time.to_formatted_s(:number)       # => "20070118061017"
  #   time.to_formatted_s(:short)        # => "18 Jan 06:10"
  #   time.to_formatted_s(:long)         # => "January 18, 2007 06:10"
  #   time.to_formatted_s(:long_ordinal) # => "January 18th, 2007 06:10"
  #   time.to_formatted_s(:rfc822)       # => "Thu, 18 Jan 2007 06:10:17 -0600"
  #
  # == Adding your own time formats to +to_formatted_s+
  # You can add your own formats to the Time::DATE_FORMATS hash.
  # Use the format name as the hash key and either a strftime string
  # or Proc instance that takes a time argument as the value.
  #
  #   # config/initializers/time_formats.rb
  #   Time::DATE_FORMATS[:month_and_year] = '%B %Y'
  #   Time::DATE_FORMATS[:short_ordinal]  = ->(time) { time.strftime("%B #{time.day.ordinalize}") }
  def to_formatted_s(format = :default)
    if formatter = DATE_FORMATS[format]
      formatter.respond_to?(:call) ? formatter.call(self).to_s : strftime(formatter)
    else
      to_default_s
    end
  end
  alias_method :to_default_s, :to_s
  alias_method :to_s, :to_formatted_s
end
