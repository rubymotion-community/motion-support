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
    #   number_to_phone(5551234)
    #     => 555-1234
    #   number_to_phone('5551234')
    #     => 555-1234
    #   number_to_phone(1235551234)
    #     => 123-555-1234
    #   number_to_phone(1235551234, area_code: true)
    #     => (123) 555-1234
    #   number_to_phone(1235551234, delimiter: ' ')
    #     => 123 555 1234
    #   number_to_phone(1235551234, area_code: true, extension: 555)
    #     => (123) 555-1234 x 555
    #   number_to_phone(1235551234, country_code: 1)
    #     => +1-123-555-1234
    #   number_to_phone('123a456')
    #     => 123a456
    #   number_to_phone(1235551234, country_code: 1, extension: 1343, delimiter: '.')
    #     => +1.123.555.1234 x 1343
    def number_to_phone(number, options = {})
      return unless number
      options = options.symbolize_keys

      delimiter = options[:delimiter] || "-"

      str = ""
      unless options[:country_code].blank?
        str << "+#{options[:country_code]}#{delimiter}"
      end
      str << format_number(number, delimiter, options[:area_code])
      str << " x #{options[:extension]}" unless options[:extension].blank?
      str
    end

    protected

    def format_number(number, delimiter, area_code)
      number_string = number.to_s.strip

      if area_code
        return number_string.gsub!(
          /(\d{1,3})(\d{3})(\d{4}$)/,
          "(\\1) \\2#{delimiter}\\3"
        ).to_s
      end

      number_string.gsub!(
        /(\d{0,3})(\d{3})(\d{4})$/,
        "\\1#{delimiter}\\2#{delimiter}\\3"
      ).to_s

      if delimiter.present? && number_string.start_with?(delimiter)
        number_string.slice!(0, 1)
      end

      number_string
    end
  end
end
