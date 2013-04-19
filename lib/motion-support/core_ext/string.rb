class String
  def humanize
    self.gsub(/(_|-)+/, ' ').strip
  end

  def titleize
    self.humanize.split(' ').map { |word| word.capitalize }.join(' ')
  end

  def dasherize
    self.underscore.humanize.split(' ').join('-')
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
    string.gsub!(/(?:_|-|(\/))([a-z\d]*)/i) do
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

  # Make a string *named* like a class name. This means
  # an under_scored string will become a CamelizedString, also it
  # will be singularized, if it is plural.
  def classify
    singularize.camelize
  end

  # Tries to find a constant with the name specified in the argument string.
  #
  #   'Module'.constantize     # => Module
  #   'Test::Unit'.constantize # => Test::Unit
  #
  # The name is assumed to be the one of a top-level constant, no matter
  # whether it starts with "::" or not. No lexical context is taken into
  # account:
  #
  #   C = 'outside'
  #   module M
  #     C = 'inside'
  #     C               # => 'inside'
  #     'C'.constantize # => 'outside', same as ::C
  #   end
  #
  # NameError is raised when the name is not in CamelCase or the constant is
  # unknown.
  def constantize
    names = self.split('::')
    names.shift if names.empty? || names.first.empty?

    names.inject(Object) do |constant, name|
      if constant == Object
        constant.const_get(name)
      else
        candidate = constant.const_get(name)
        next candidate if constant.const_defined?(name, false)
        next candidate unless Object.const_defined?(name)

        # Go down the ancestors to check it it's owned
        # directly before we reach Object or the end of ancestors.
        constant = constant.ancestors.inject do |const, ancestor|
          break const    if ancestor == Object
          break ancestor if ancestor.const_defined?(name, false)
          const
        end

        # owner is in Object, so raise
        constant.const_get(name, false)
      end
    end
  end
end
