# This is a very small part of the CGI class, borrowed from the Rubinius sources
class CGI
  @@accept_charset = "UTF-8" unless defined?(@@accept_charset)
  # URL-encode a string.
  #   url_encoded_string = CGI::escape("'Stop!' said Fred")
  #      # => "%27Stop%21%27+said+Fred"
  def self::escape(string)
    string.gsub(/([^ a-zA-Z0-9_.-]+)/) do
      "%" + $1.unpack("H2" * $1.bytesize).join("%").upcase
    end.tr(" ", "+")
  end

  # URL-decode a string with encoding(optional).
  #   string = CGI::unescape("%27Stop%21%27+said+Fred")
  #      # => "'Stop!' said Fred"
  def self::unescape(string, encoding = @@accept_charset)
    str = string.tr("+", " ").force_encoding(Encoding::ASCII_8BIT).gsub(/((?:%[0-9a-fA-F]{2})+)/) do
      [$1.delete("%")].pack("H*")
    end.force_encoding(encoding)
    str.valid_encoding? ? str : str.force_encoding(string.encoding)
  end
end
