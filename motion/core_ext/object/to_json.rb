# encoding: utf-8

class Object
  # Serializes the object to a hash then the hash using Cocoa's NSJSONSerialization
  def to_json
    attributes = {}

    self.instance_variables.each do |attribute|
      key = attribute.to_s.gsub('@', '')
      attributes[key] = self.instance_variable_get(attribute)
    end

    attributes.to_json
  end
end

class NilClass
  # Returns 'null'.
  def to_json
    'null'
  end
end

class TrueClass
  # Returns +self+ as string.
  def to_json
    self.to_s
  end
end

class FalseClass
  # Returns +self+ as string.
  def to_json
    self.to_s
  end
end

class JSONString
  # JSON escape characters
  class << self
    ESCAPED_CHARS = {
      "\u0000" => '\u0000', "\u0001" => '\u0001',
      "\u0002" => '\u0002', "\u0003" => '\u0003',
      "\u0004" => '\u0004', "\u0005" => '\u0005',
      "\u0006" => '\u0006', "\u0007" => '\u0007',
      "\u0008" => '\b',     "\u0009" => '\t',
      "\u000A" => '\n',     "\u000B" => '\u000B',
      "\u000C" => '\f',     "\u000D" => '\r',
      "\u000E" => '\u000E', "\u000F" => '\u000F',
      "\u0010" => '\u0010', "\u0011" => '\u0011',
      "\u0012" => '\u0012', "\u0013" => '\u0013',
      "\u0014" => '\u0014', "\u0015" => '\u0015',
      "\u0016" => '\u0016', "\u0017" => '\u0017',
      "\u0018" => '\u0018', "\u0019" => '\u0019',
      "\u001A" => '\u001A', "\u001B" => '\u001B',
      "\u001C" => '\u001C', "\u001D" => '\u001D',
      "\u001E" => '\u001E', "\u001F" => '\u001F',
      "\u2028" => '\u2028', "\u2029" => '\u2029',
      '"'  => '\"',
      '\\' => '\\\\',
      '>' => '\u003E',
      '<' => '\u003C',
      '&' => '\u0026'}

    ESCAPE_REGEX = /[\u0000-\u001F\u2028\u2029"\\><&]/u

    def escape(string)
      %("#{string.gsub ESCAPE_REGEX, ESCAPED_CHARS}")
    end
  end
end

class String
  # Returns JSON-escaped +self+.
  def to_json
    JSONString.escape self
  end
end

class Symbol
  # Returns +self+ as string.
  def to_json
    self.to_s
  end
end

class Numeric
  # Returns +self+.
  def to_json
    self
  end
end

# For more complex objects (Array/Hash):
# Convert an object into a "JSON-ready" representation composed of
# primitives like Hash, Array, String, Numeric, and true/false/nil.
# Recursively calls #as_json to the object to recursively build a
# fully JSON-ready object.
#
# This allows developers to implement #as_json without having to
# worry about what base types of objects they are allowed to return
# or having to remember to call #as_json recursively.

class Array
  def as_json
    map { |v| (v.respond_to?(:as_json) ? v.as_json : v) }
  end

  # Calls <tt>as_json</tt> on all its elements and converts to a string.
  def to_json
    NSJSONSerialization.dataWithJSONObject(as_json, options: 0, error: nil).to_s
  end
end

class Hash
  # Ensure there are valid keys/values
  def as_json
    Hash[map { |k,v| [k.to_s, (v.respond_to?(:as_json) ? v.as_json : v)] }]
  end

  # Serializes the hash object using Cocoa's NSJSONSerialization
  def to_json
    # JSON keys must be strings, and any sub-objects also serialized
    NSJSONSerialization.dataWithJSONObject(as_json, options: 0, error: nil).to_s
  end
end
