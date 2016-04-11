class Time
  DATE_FORMATS = {
    :db           => '%Y-%m-%d %H:%M:%S',
    :number       => '%Y%m%d%H%M%S',
    :nsec         => '%Y%m%d%H%M%S%9N',
    :time         => '%H:%M',
    :short        => '%d %b %H:%M',
    :long         => '%B %d, %Y %H:%M',
    :long_ordinal => lambda { |time|
      day_format = MotionSupport::Inflector.ordinalize(time.day)
      time.strftime("%B #{day_format}, %Y %H:%M")
    },
    :rfc822       => lambda { |time|
      offset_format = time.formatted_offset(false)
      time.strftime("%a, %d %b %Y %H:%M:%S #{offset_format}")
    },
    :iso8601      => '%Y-%m-%dT%H:%M:%SZ'
  }

  # Accepts a iso8601 time string and returns a new instance of Time
  def self.iso8601(time_string)
    format_string = "yyyy-MM-dd'T'HH:mm:ss"

    # Fractional Seconds
    format_string += '.SSS' if time_string.include?('.')

    # Zulu (standard) or with a timezone
    format_string += time_string.include?('Z') ? "'Z'" : 'ZZZZZ'

    cached_date_formatter(format_string).dateFromString(time_string)
  end

  # Returns an iso8601-compliant string
  # This method is aliased to <tt>xmlschema</tt>.
  def iso8601
    utc.strftime DATE_FORMATS[:iso8601]
  end
  alias_method :xmlschema, :iso8601

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
    return iso8601 if format == :iso8601

    formatter = DATE_FORMATS[format]

    return to_default_s unless formatter

    return formatter.call(self).to_s if formatter.respond_to?(:call)

    strftime(formatter)
  end
  alias_method :to_default_s, :to_s
  alias_method :to_s, :to_formatted_s

  private

  def self.cached_date_formatter(dateFormat)
    Thread.current[:date_formatters] ||= {}
    Thread.current[:date_formatters][dateFormat] ||=
      NSDateFormatter.alloc.init.tap do |formatter|
        formatter.dateFormat = dateFormat
        formatter.timeZone   = NSTimeZone.timeZoneWithAbbreviation 'UTC'
      end
  end
  private_class_method :cached_date_formatter
end
