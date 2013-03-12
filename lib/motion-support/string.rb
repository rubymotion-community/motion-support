class String
  def humanize
    self.split(/_|-| /).join(' ')
  end

  def titleize
    self.split(/_|-| /).each{|word| word[0...1] = word[0...1].upcase}.join(' ')
  end

  def empty?
    self.length < 1
  end

  def pluralize
    Inflector.inflections.pluralize self
  end

  def singularize
    Inflector.inflections.singularize self
  end

  def camelize(uppercase_first_letter = true)
    string = self.dup
    string.gsub!(/(?:_|(\/))([a-z\d]*)/i) do
      new_word = $2.downcase
      new_word[0] = new_word[0].upcase
      new_word = "/#{new_word}" if $1 == '/'
      new_word
    end
    if uppercase_first_letter && uppercase_first_letter != :lower
      string[0] = string[0].upcase
    else
      string[0] = string[0].downcase
    end
    string.gsub!('/', '::')
    string
  end

  def underscore
    word = self.dup
    word.gsub!(/::/, '/')
    word.gsub!(/([A-Z\d]+)([A-Z][a-z])/,'\1_\2')
    word.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
    word.tr!("-", "_")
    word.downcase!
    word
  end

  # This method makes a string *be* like a class name. This means an under_scored string will become
  # a CamelizedString, also it will be singularized, if it is plural. Note: This is a behavioral
  # difference from previous versions insofar as this method returns a constant and not a string.
  #
  # You can now do things like:
  #
  # @person = "Person".classify.new
  def classify
    Object.const_get(self.singularize.camelize)
  end
end
