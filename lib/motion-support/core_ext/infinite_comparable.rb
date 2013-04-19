motion_require 'module/aliasing'
motion_require "../concern"

module InfiniteComparable
  extend MotionSupport::Concern

  included do
    alias_method_chain :<=>, :infinity
  end

  define_method :'<=>_with_infinity' do |other|
    if other.class == self.class
      public_send :'<=>_without_infinity', other
    else
      infinite = try(:infinite?)
      other_infinite = other.try(:infinite?)

      # inf <=> inf
      if infinite && other_infinite
        infinite <=> other_infinite
      # not_inf <=> inf
      elsif other_infinite
        -other_infinite
      # inf <=> not_inf
      elsif infinite
        infinite
      else
        conversion = "to_#{self.class.name.downcase}"
        other = other.public_send(conversion) if other.respond_to?(conversion)
        public_send :'<=>_without_infinity', other
      end
    end
  end
end
