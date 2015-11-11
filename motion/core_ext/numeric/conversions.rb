class Numeric
  # Provides options for converting numbers into formatted strings.
  # Right now, options are only provided for phone numbers.
  #
  # ==== Options
  #
  # For details on which formats use which options, see MotionSupport::NumberHelper
  #
  # ==== Examples
  #
  #  Phone Numbers:
  #  5551234.to_s(:phone)                                     # => 555-1234
  #  1235551234.to_s(:phone)                                  # => 123-555-1234
  #  1235551234.to_s(:phone, area_code: true)                 # => (123) 555-1234
  #  1235551234.to_s(:phone, delimiter: ' ')                  # => 123 555 1234
  #  1235551234.to_s(:phone, area_code: true, extension: 555) # => (123) 555-1234 x 555
  #  1235551234.to_s(:phone, country_code: 1)                 # => +1-123-555-1234
  #  1235551234.to_s(:phone, country_code: 1, extension: 1343, delimiter: '.')
  #  # => +1.123.555.1234 x 1343
  def to_formatted_s(format = :default, options = {})
    case format
    when :phone
      return MotionSupport::NumberHelper.number_to_phone(self, options)
    else
      self.to_default_s
    end
  end

  [Float, Fixnum, Bignum].each do |klass|
    klass.send(:alias_method, :to_default_s, :to_s)

    klass.send(:define_method, :to_s) do |*args|
      if args[0].is_a?(Symbol)
        format = args[0]
        options = args[1] || {}

        self.to_formatted_s(format, options)
      else
        to_default_s(*args)
      end
    end
  end
end
