module Enumerable
  # Iterates through a container, yielding each element and its index to the given block.
  def collect_with_index(&block)
    index = 0
    collect do |value|
      block.call(value, index).tap do
        index += 1
      end
    end
  end
end
