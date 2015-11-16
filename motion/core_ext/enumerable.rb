module Enumerable
  # Iterates through a container, yielding each element and its index to the given block.
  def collect_with_index(&block)
    index = 0
    map do |value|
      block.call(value, index).tap { index += 1 }
    end
  end

  # Calculates a sum from the elements.
  #
  #  payments.sum { |p| p.price * p.tax_rate }
  #  payments.sum(&:price)
  #
  # The latter is a shortcut for:
  #
  #  payments.inject(0) { |sum, p| sum + p.price }
  #
  # It can also calculate the sum without the use of a block.
  #
  #  [5, 15, 10].sum # => 30
  #  ['foo', 'bar'].sum # => "foobar"
  #  [[1, 2], [3, 1, 5]].sum => [1, 2, 3, 1, 5]
  #
  # The default sum of an empty list is zero. You can override this default:
  #
  #  [].sum(Payment.new(0)) { |i| i.amount } # => Payment.new(0)
  def sum(identity = 0, &block)
    return map(&block).sum(identity) if block_given?

    inject { |sum, element| sum + element } || identity
  end

  # Convert an enumerable to a hash.
  #
  #   people.index_by(&:login)
  #     => { "nextangle" => <Person ...>, "chade-" => <Person ...>, ...}
  #   people.index_by { |person| "#{person.first_name} #{person.last_name}" }
  #     => {
  #          "Chade- Fowlersburg-e" => <Person ...>,
  #          "David Heinemeier Hansson" => <Person ...>,
  #          ...
  #        }
  def index_by
    return Hash[map { |elem| [yield(elem), elem] }] if block_given?

    to_enum :index_by
  end

  # Returns +true+ if the enumerable has more than 1 element. Functionally
  # equivalent to <tt>enum.to_a.size > 1</tt>. Can be called with a block too,
  # much like any?, so <tt>people.many? { |p| p.age > 26 }</tt> returns +true+
  # if more than one person is over 26.
  def many?
    cnt = 0
    return any? { (cnt += 1) > 1 } unless block_given?

    any? do |element|
      cnt += 1 if yield element
      cnt > 1
    end
  end

  # The negative of the <tt>Enumerable#include?</tt>. Returns +true+ if the
  # collection does not include the object.
  def exclude?(object)
    !include?(object)
  end
end

class Range #:nodoc:
  # Optimize range sum to use arithmetic progression if a block is not given and
  # we have a range of numeric values.
  def sum(identity = 0)
    return super if block_given? || !(first.is_a?(Integer) && last.is_a?(Integer))

    actual_last = exclude_end? ? (last - 1) : last

    return identity unless actual_last >= first

    (actual_last - first + 1) * (actual_last + first) / 2
  end
end
