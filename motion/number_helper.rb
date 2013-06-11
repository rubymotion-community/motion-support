module MotionSupport
  module NumberHelper
    extend self

    # Formats a +number+ into a US phone number (e.g., (555)
    # 123-9876). You can customize the format in the +options+ hash.
    #
    # ==== Options
    #
    # * <tt>:area_code</tt> - Adds parentheses around the area code.
    # * <tt>:delimiter</tt> - Specifies the delimiter to use
    #   (defaults to "-").
    # * <tt>:extension</tt> - Specifies an extension to add to the
    #   end of the generated number.
    # * <tt>:country_code</tt> - Sets the country code for the phone
    #   number.
    # ==== Examples
    #
    #   number_to_phone(5551234)                                     # => 555-1234
    #   number_to_phone('5551234')                                   # => 555-1234
    #   number_to_phone(1235551234)                                  # => 123-555-1234
    #   number_to_phone(1235551234, area_code: true)                 # => (123) 555-1234
    #   number_to_phone(1235551234, delimiter: ' ')                  # => 123 555 1234
    #   number_to_phone(1235551234, area_code: true, extension: 555) # => (123) 555-1234 x 555
    #   number_to_phone(1235551234, country_code: 1)                 # => +1-123-555-1234
    #   number_to_phone('123a456')                                   # => 123a456
    #
    #   number_to_phone(1235551234, country_code: 1, extension: 1343, delimiter: '.')
    #   # => +1.123.555.1234 x 1343
    def number_to_phone(number, options = {})
      return unless number
      options = options.symbolize_keys

      number       = number.to_s.strip
      area_code    = options[:area_code]
      delimiter    = options[:delimiter] || "-"
      extension    = options[:extension]
      country_code = options[:country_code]

      if area_code
        number.gsub!(/(\d{1,3})(\d{3})(\d{4}$)/,"(\\1) \\2#{delimiter}\\3")
      else
        number.gsub!(/(\d{0,3})(\d{3})(\d{4})$/,"\\1#{delimiter}\\2#{delimiter}\\3")
        number.slice!(0, 1) if number.start_with?(delimiter) && !delimiter.blank?
      end

      str = ''
      str << "+#{country_code}#{delimiter}" unless country_code.blank?
      str << number
      str << " x #{extension}" unless extension.blank?
      str
    end
  end
end