class Object
  # Returns true if this object is included in the argument(s). Argument must be
  # any object which responds to +#include?+ or optionally, multiple arguments
  # can be passed in. Usage:
  #
  #   characters = ['Konata', 'Kagami', 'Tsukasa']
  #   'Konata'.in?(characters) # => true
  #
  # This will throw an ArgumentError it doesn't respond to +#include?+.
  def __in_workaround(args)
    args.include?(self)
  rescue NoMethodError
    raise ArgumentError.new("The parameter passed to #in? must respond to #include?")
  end
  alias in? __in_workaround
end
