class Object
  # Returns true if this object is included in the argument(s). Argument must be
  # any object which responds to +#include?+. Usage:
  #
  #   characters = ['Konata', 'Kagami', 'Tsukasa']
  #   'Konata'.in?(characters) # => true
  #
  # This will throw an ArgumentError it doesn't respond to +#include?+.
  def in?(args)
    args.include?(self)
  rescue NoMethodError
    raise ArgumentError.new("The parameter passed to #in? must respond to #include?")
  end

  # Returns the receiver if it's included in the argument otherwise returns +nil+.
  # Argument must be any object which responds to +#include?+. Usage:
  #
  #   params[:bucket_type].presence_in %w( project calendar )
  #
  # This will throw an ArgumentError if the argument doesn't respond to +#include?+.
  #
  # @return [Object]
  def presence_in(another_object)
    self.in?(another_object) ? self : nil
  end
end
