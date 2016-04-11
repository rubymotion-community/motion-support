class Date
  DATE_FORMATS = {
    :short        => '%e %b',
    :long         => '%B %e, %Y',
    :db           => '%Y-%m-%d',
    :number       => '%Y%m%d',
    :long_ordinal => lambda { |date|
      day_format = MotionSupport::Inflector.ordinalize(date.day)
      date.strftime("%B #{day_format}, %Y") # => "April 25th, 2007"
    },
    :rfc822       => '%e %b %Y',
    :iso8601      => '%Y-%m-%d',
    :xmlschema    => '%Y-%m-%dT00:00:00Z'
  }

  def iso8601
    strftime DATE_FORMATS[:iso8601]
  end

  # Convert to a formatted string. See DATE_FORMATS for predefined formats.
  #
  # This method is aliased to <tt>to_s</tt>.
  #
  #   date = Date.new(2007, 11, 10)       # => Sat, 10 Nov 2007
  #
  #   date.to_formatted_s(:db)            # => "2007-11-10"
  #   date.to_s(:db)                      # => "2007-11-10"
  #
  #   date.to_formatted_s(:short)         # => "10 Nov"
  #   date.to_formatted_s(:long)          # => "November 10, 2007"
  #   date.to_formatted_s(:long_ordinal)  # => "November 10th, 2007"
  #   date.to_formatted_s(:rfc822)        # => "10 Nov 2007"
  #
  # == Adding your own time formats to to_formatted_s
  # You can add your own formats to the Date::DATE_FORMATS hash.
  # Use the format name as the hash key and either a strftime string
  # or Proc instance that takes a date argument as the value.
  #
  #   # config/initializers/time_formats.rb
  #   Date::DATE_FORMATS[:month_and_year] = '%B %Y'
  #   Date::DATE_FORMATS[:short_ordinal] = ->(date) { date.strftime("%B #{date.day.ordinalize}") }
  def to_formatted_s(format = :default)
    formatter = DATE_FORMATS[format]

    return to_default_s unless formatter

    return formatter.call(self).to_s if formatter.respond_to?(:call)

    strftime(formatter)
  end
  alias_method :to_default_s, :to_s
  alias_method :to_s, :to_formatted_s

  # Overrides the default inspect method with a human readable one, e.g., "Mon, 21 Feb 2005"
  def readable_inspect
    strftime('%a, %d %b %Y')
  end
  alias_method :default_inspect, :inspect
  alias_method :inspect, :readable_inspect

  def xmlschema
    strftime DATE_FORMATS[:xmlschema]
  end
end
