class Hash
  # Returns a new hash with keys deleted if they match a criteria
  #   h1 = { x: { y: [ { z: 4, y: 1 }, 5, 6] }, a: { b: 2 }  }
  #
  #   h1.deep_delete { |k,v| k == :z } #=> { x: { y: [ { y: 1 }, 5, 6] }, a: { b: 2 }  }
  #   h1.deep_delete { |k,v| k == :y } #=> { x: {}, a: { b: 2 }  }
  def deep_delete_if(&block)
    result = {}
    each do |key, value|
      next if block.call(key, value)

      result[key] = if value.is_a?(Hash)
                      value.deep_delete_if(&block)
                    elsif value.is_a?(Array)
                      value.map { |v| v.is_a?(Hash) ? v.deep_delete_if(&block) : v }
                    else
                      value
      end
    end

    result
  end
end
