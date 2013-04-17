class Array
  # Converts the array to a comma-separated sentence where the last element is
  # joined by the connector word.
  #
  # You can pass the following options to change the default behavior. If you
  # pass an option key that doesn't exist in the list below, it will raise an
  # <tt>ArgumentError</tt>.
  #
  # Options:
  #
  # * <tt>:words_connector</tt> - The sign or word used to join the elements
  #   in arrays with two or more elements (default: ", ").
  # * <tt>:two_words_connector</tt> - The sign or word used to join the elements
  #   in arrays with two elements (default: " and ").
  # * <tt>:last_word_connector</tt> - The sign or word used to join the last element
  #   in arrays with three or more elements (default: ", and ").
  #
  #   [].to_sentence                      # => ""
  #   ['one'].to_sentence                 # => "one"
  #   ['one', 'two'].to_sentence          # => "one and two"
  #   ['one', 'two', 'three'].to_sentence # => "one, two, and three"
  #
  #   ['one', 'two'].to_sentence(passing: 'invalid option')
  #   # => ArgumentError: Unknown key :passing
  #
  #   ['one', 'two'].to_sentence(two_words_connector: '-')
  #   # => "one-two"
  #
  #   ['one', 'two', 'three'].to_sentence(words_connector: ' or ', last_word_connector: ' or at least ')
  #   # => "one or two or at least three"
  def to_sentence(options = {})
    options.assert_valid_keys(:words_connector, :two_words_connector, :last_word_connector)

    default_connectors = {
      :words_connector     => ', ',
      :two_words_connector => ' and ',
      :last_word_connector => ', and '
    }
    options = default_connectors.merge!(options)

    case length
    when 0
      ''
    when 1
      self[0].to_s.dup
    when 2
      "#{self[0]}#{options[:two_words_connector]}#{self[1]}"
    else
      "#{self[0...-1].join(options[:words_connector])}#{options[:last_word_connector]}#{self[-1]}"
    end
  end

  # Converts a collection of elements into a formatted string by calling
  # <tt>to_s</tt> on all elements and joining them. Having this model:
  #
  #   class Blog < ActiveRecord::Base
  #     def to_s
  #       title
  #     end
  #   end
  #
  #   Blog.all.map(&:title) #=> ["First Post", "Second Post", "Third post"]
  #
  # <tt>to_formatted_s</tt> shows us:
  #
  #   Blog.all.to_formatted_s # => "First PostSecond PostThird Post"
  #
  # Adding in the <tt>:db</tt> argument as the format yields a comma separated
  # id list:
  #
  #   Blog.all.to_formatted_s(:db) # => "1,2,3"
  def to_formatted_s(format = :default)
    case format
    when :db
      if empty?
        'null'
      else
        collect { |element| element.id }.join(',')
      end
    else
      to_default_s
    end
  end
  alias_method :to_default_s, :to_s
  alias_method :to_s, :to_formatted_s
end
