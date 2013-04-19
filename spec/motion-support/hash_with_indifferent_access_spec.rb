class IndifferentHash < MotionSupport::HashWithIndifferentAccess
end

class SubclassingArray < Array
end

class SubclassingHash < Hash
end

class NonIndifferentHash < Hash
  def nested_under_indifferent_access
    self
  end
end

describe "HashWithIndifferentAccess" do
  before do
    @strings = { 'a' => 1, 'b' => 2 }
    @nested_strings = { 'a' => { 'b' => { 'c' => 3 } } }
    @symbols = { :a  => 1, :b  => 2 }
    @nested_symbols = { :a => { :b => { :c => 3 } } }
    @mixed   = { :a  => 1, 'b' => 2 }
    @nested_mixed   = { 'a' => { :b => { 'c' => 3 } } }
    @fixnums = {  0  => 1,  1  => 2 }
    @nested_fixnums = {  0  => { 1  => { 2 => 3} } }
    @illegal_symbols = { [] => 3 }
    @nested_illegal_symbols = { [] => { [] => 3} }
    @upcase_strings = { 'A' => 1, 'B' => 2 }
    @nested_upcase_strings = { 'A' => { 'B' => { 'C' => 3 } } }
  end
  
  describe "constructor" do
    it "should construct hash" do
      hash = HashWithIndifferentAccess[:foo, 1]
      hash[:foo].should == 1
      hash['foo'].should == 1
      hash[:foo] = 3
      hash[:foo].should == 3
      hash['foo'].should == 3
    end
    
    it "should return duplicate for with_indifferent_access" do
      hash_wia = HashWithIndifferentAccess.new
      hash_wia.with_indifferent_access.should == hash_wia
      hash_wia.with_indifferent_access.object_id.should.not == hash_wia.object_id
    end
  end
  
  describe "conversion" do
    it "should not convert other key objects" do
      original = {Object.new => 2, 1 => 2, [] => true}
      indiff = original.with_indifferent_access
      indiff.keys.any? {|k| k.kind_of? String}.should == false
    end
  end
  
  describe "symbolize_keys" do
    it "should return normal hash instance" do
      @symbols.with_indifferent_access.symbolize_keys.should.is_a Hash
    end
    
    it "should symbolize keys" do
      @symbols.with_indifferent_access.symbolize_keys.should == @symbols
      @strings.with_indifferent_access.symbolize_keys.should == @symbols
      @mixed.with_indifferent_access.symbolize_keys.should == @symbols
    end
    
    it "should preserve keys that can't be symbolized" do
      @illegal_symbols.with_indifferent_access.symbolize_keys.should == @illegal_symbols
      lambda { @illegal_symbols.with_indifferent_access.dup.symbolize_keys! }.should.raise NoMethodError
    end
    
    it "should preserve Fixnum keys" do
      @fixnums.with_indifferent_access.symbolize_keys.should == @fixnums
      lambda { @fixnums.with_indifferent_access.dup.symbolize_keys! }.should.raise NoMethodError
    end
    
    it "should preserve hash" do
      h = HashWithIndifferentAccess.new
      h['first'] = 1
      h = h.symbolize_keys
      h[:first].should == 1
    end
  end
  
  describe "symbolize_keys!" do
    it "should not work" do
      lambda { @symbols.with_indifferent_access.dup.symbolize_keys! }.should.raise NoMethodError
      lambda { @strings.with_indifferent_access.dup.symbolize_keys! }.should.raise NoMethodError
      lambda { @mixed.with_indifferent_access.dup.symbolize_keys! }.should.raise NoMethodError
    end
  end
  
  describe "deep_symbolize_keys" do
    it "should return normal hash instance" do
      @symbols.with_indifferent_access.deep_symbolize_keys.should.is_a Hash
    end
    
    it "should deep symbolize keys" do
      @nested_symbols.with_indifferent_access.deep_symbolize_keys.should == @nested_symbols
      @nested_strings.with_indifferent_access.deep_symbolize_keys.should == @nested_symbols
      @nested_mixed.with_indifferent_access.deep_symbolize_keys.should == @nested_symbols
    end
    
    it "should preserve keys that can't be symbolized" do
      @nested_illegal_symbols.with_indifferent_access.deep_symbolize_keys.should == @nested_illegal_symbols
      lambda { @nested_illegal_symbols.with_indifferent_access.deep_dup.deep_symbolize_keys! }.should.raise NoMethodError
    end
    
    it "should preserve Fixnum keys for" do
      @nested_fixnums.with_indifferent_access.deep_symbolize_keys.should == @nested_fixnums
      lambda { @nested_fixnums.with_indifferent_access.deep_dup.deep_symbolize_keys! }.should.raise NoMethodError
    end
    
    it "should preserve hash" do
      h = HashWithIndifferentAccess.new
      h['first'] = 1
      h = h.deep_symbolize_keys
      h[:first].should == 1
    end
  end
  
  describe "deep_symbolize_keys!" do
    it "should not work" do
      lambda { @nested_symbols.with_indifferent_access.deep_dup.deep_symbolize_keys! }.should.raise NoMethodError
      lambda { @nested_strings.with_indifferent_access.deep_dup.deep_symbolize_keys! }.should.raise NoMethodError
      lambda { @nested_mixed.with_indifferent_access.deep_dup.deep_symbolize_keys! }.should.raise NoMethodError
    end
  end
  
  describe "stringify_keys" do
    it "should return hash with indifferent access" do
      @symbols.with_indifferent_access.stringify_keys.should.is_a MotionSupport::HashWithIndifferentAccess
    end
    
    it "should stringify keys" do
      @symbols.with_indifferent_access.stringify_keys.should == @strings
      @strings.with_indifferent_access.stringify_keys.should == @strings
      @mixed.with_indifferent_access.stringify_keys.should == @strings
    end
    
    it "should preserve hash" do
      h = HashWithIndifferentAccess.new
      h[:first] = 1
      h = h.stringify_keys
      h['first'].should == 1
    end
  end
  
  describe "deep_stringify_keys" do
    it "should return hash with indifferent access" do
      @nested_symbols.with_indifferent_access.deep_stringify_keys.should.is_a MotionSupport::HashWithIndifferentAccess
    end
    
    it "should deep stringify keys" do
      @nested_symbols.with_indifferent_access.deep_stringify_keys.should == @nested_strings
      @nested_strings.with_indifferent_access.deep_stringify_keys.should == @nested_strings
      @nested_mixed.with_indifferent_access.deep_stringify_keys.should == @nested_strings
    end
    
    it "should preserve hash" do
      h = HashWithIndifferentAccess.new
      h[:first] = 1
      h = h.deep_stringify_keys
      h['first'].should == 1
    end
  end
  
  describe "stringify_keys!" do
    it "should return hash with indifferent access" do
      @symbols.with_indifferent_access.dup.stringify_keys!.should.is_a MotionSupport::HashWithIndifferentAccess
    end

    it "should stringify keys (for dupped instance)" do
      @symbols.with_indifferent_access.dup.stringify_keys!.should == @strings
      @strings.with_indifferent_access.dup.stringify_keys!.should == @strings
      @mixed.with_indifferent_access.dup.stringify_keys!.should == @strings
    end
  end
  
  describe "deep_stringify_keys!" do
    it "should return hash with indifferent access" do
      @nested_symbols.with_indifferent_access.dup.deep_stringify_keys!.should.is_a MotionSupport::HashWithIndifferentAccess
    end

    it "should stringify keys (for deep_dupped instance)" do
      @nested_symbols.with_indifferent_access.deep_dup.deep_stringify_keys!.should == @nested_strings
      @nested_strings.with_indifferent_access.deep_dup.deep_stringify_keys!.should == @nested_strings
      @nested_mixed.with_indifferent_access.deep_dup.deep_stringify_keys!.should == @nested_strings
    end
  end
  
  describe "reading" do
    it "should read string keys with symbol access" do
      hash = HashWithIndifferentAccess.new
      hash["a"] = 1
      hash["b"] = true
      hash["c"] = false
      hash["d"] = nil

      hash[:a].should == 1
      hash[:b].should == true
      hash[:c].should == false
      hash[:d].should == nil
      hash[:e].should == nil
    end
    
    it "should read string keys with symbol access and nonnil default" do
      hash = HashWithIndifferentAccess.new(1)
      hash["a"] = 1
      hash["b"] = true
      hash["c"] = false
      hash["d"] = nil

      hash[:a].should == 1
      hash[:b].should == true
      hash[:c].should == false
      hash[:d].should == nil
      hash[:e].should == 1
    end
    
    it "should return the same object that is stored" do
      hash = HashWithIndifferentAccess.new {|h, k| h[k] = []}
      hash[:a] << 1

      hash[:a].should == [1]
    end
  end
  
  describe "writing" do
    it "should write with symbols and strings" do
      hash = HashWithIndifferentAccess.new
      hash[:a] = 1
      hash['b'] = 2

      hash['a'].should == 1
      hash['b'].should == 2
      hash[:a].should == 1
      hash[:b].should == 2
    end
    
    it "should not symbolize or stringify numbers" do
      hash = HashWithIndifferentAccess.new
      hash[3] = 3

      hash[3].should == 3
      hash[:'3'].should == nil
      hash['3'].should == nil
    end
    
    it "should store values" do
      hash = HashWithIndifferentAccess.new
      hash.store(:test1, 1)
      hash.store('test1', 11)
      hash[:test2] = 2
      hash['test2'] = 22
      expected = { "test1" => 11, "test2" => 22 }
      hash.should == expected
    end
  end
  
  describe "update" do
    before do
      @hash = HashWithIndifferentAccess.new
      @hash[:a] = 'a'
      @hash['b'] = 'b'
    end
    
    it "should update with string keys" do
      updated_with_strings = @hash.update(@strings)
      updated_with_strings[:a].should == 1
      updated_with_strings['a'].should == 1
      updated_with_strings['b'].should == 2

      updated_with_strings.keys.size.should == 2
    end
    
    it "should update with symbol keys" do
      updated_with_symbols = @hash.update(@symbols)
      updated_with_symbols[:a].should == 1
      updated_with_symbols['b'].should == 2
      updated_with_symbols[:b].should == 2
      
      updated_with_symbols.keys.size.should == 2
    end
    
    it "should update with mixed keys" do
      updated_with_mixed = @hash.update(@mixed)
      updated_with_mixed[:a].should == 1
      updated_with_mixed['b'].should == 2
      
      updated_with_mixed.keys.size.should == 2
    end
  end
  
  describe "merge" do
    describe "without block" do
      before do
        @hash = HashWithIndifferentAccess.new
        @hash[:a] = 'failure'
        @hash['b'] = 'failure'

        @other = { 'a' => 1, :b => 2 }
      end

      it "should merge with mixed hash" do
        merged = @hash.merge(@other)

        merged.class.should == HashWithIndifferentAccess
        merged[:a].should == 1
        merged['b'].should == 2
      end

      it "should have the same effect inplace when updating" do
        @hash.update(@other)

        @hash[:a].should == 1
        @hash['b'].should == 2
      end
    end
    
    describe "with block" do
      before do
        @hash = HashWithIndifferentAccess.new
        @hash[:a] = 1
        @hash['b'] = 3
      end
      
      it "should merge with block" do
        other = { 'a' => 4, :b => 2, 'c' => 10 }

        merged = @hash.merge(other) { |key, old, new| old > new ? old : new }

        merged.class.should == HashWithIndifferentAccess
        merged[:a].should == 4
        merged['b'].should == 3
        merged[:c].should == 10
      end

      it "should merge with block one more time" do
        other_indifferent = HashWithIndifferentAccess.new('a' => 9, :b => 2)

        merged = @hash.merge(other_indifferent) { |key, old, new| old + new }

        merged.class.should == HashWithIndifferentAccess
        merged[:a].should == 10
        merged[:b].should == 5
      end
    end
  end
  
  describe "reverse_merge" do
    it "should reverse merge" do
      hash = HashWithIndifferentAccess.new('some' => 'value', 'other' => 'value')
      hash.reverse_merge!(:some => 'noclobber', :another => 'clobber')
      hash[:some].should == 'value'
      hash[:another].should == 'clobber'
    end
  end
  
  describe "replace" do
    before do
      @hash = HashWithIndifferentAccess.new
      @hash[:a] = 42

      @replaced = @hash.replace(b: 12)
    end
    
    it "should replace with regular hash" do
      @hash.key?('b').should == true
      @hash.key?(:a).should == false
      @hash[:b].should == 12
    end
    
    it "should be the same class" do
      @replaced.class.should == HashWithIndifferentAccess
    end
    
    it "should be the same object" do
      @hash.object_id.should == @replaced.object_id
    end
  end
  
  describe "delete" do
    before do
      @hash = { :a => 'foo' }.with_indifferent_access
    end
    
    it "should delete with symbol keys" do
      @hash.delete(:a).should == 'foo'
      @hash.delete(:a).should == nil
    end
    
    it "should delete with string keys" do
      @hash.delete('a').should == 'foo'
      @hash.delete('a').should == nil
    end
  end
  
  describe "to_hash" do
    it "should return a hash with string keys" do
      @mixed.with_indifferent_access.to_hash.should == @strings
    end

    it "should preserve the default value" do
      mixed_with_default = @mixed.dup
      mixed_with_default.default = '1234'
      roundtrip = mixed_with_default.with_indifferent_access.to_hash
      roundtrip.should == @strings
      roundtrip.default.should == '1234'
    end
  end
  
  describe "to_options" do
    it "should preserve hash" do
      h = HashWithIndifferentAccess.new
      h['first'] = 1
      h.to_options!
      h['first'].should == 1
    end
  end
  
  describe "nesting" do
    it "should preserve hash subclasses in nested hashes" do
      foo = { "foo" => SubclassingHash.new.tap { |h| h["bar"] = "baz" } }.with_indifferent_access
      foo["foo"].should.is_a MotionSupport::HashWithIndifferentAccess

      foo = { "foo" => NonIndifferentHash.new.tap { |h| h["bar"] = "baz" } }.with_indifferent_access
      foo["foo"].should.is_a NonIndifferentHash

      foo = { "foo" => IndifferentHash.new.tap { |h| h["bar"] = "baz" } }.with_indifferent_access
      foo["foo"].should.is_a IndifferentHash
    end
    
    it "should deep apply indifferent access" do
      hash = { "urls" => { "url" => [ { "address" => "1" }, { "address" => "2" } ] }}.with_indifferent_access
      hash[:urls][:url].first[:address].should == "1"
    end
    
    it "should preserve array subclass when value is array" do
      array = SubclassingArray.new
      array << { "address" => "1" }
      hash = { "urls" => { "url" => array }}.with_indifferent_access
      hash[:urls][:url].class.should == SubclassingArray
    end

    it "should preserve array class when hash value is frozen array" do
      array = SubclassingArray.new
      array << { "address" => "1" }
      hash = { "urls" => { "url" => array.freeze }}.with_indifferent_access
      hash[:urls][:url].class.should == SubclassingArray
    end
    
    it "should allow indifferent access on sub hashes" do
      h = {'user' => {'id' => 5}}.with_indifferent_access
      ['user', :user].each { |user| [:id, 'id'].each { |id| h[user][id].should == 5 } }

      h = {:user => {:id => 5}}.with_indifferent_access
      ['user', :user].each { |user| [:id, 'id'].each { |id| h[user][id].should == 5 } }
    end
  end
  
  describe "dup" do
    it "should preserve default value" do
      h = HashWithIndifferentAccess.new
      h.default = '1234'
      h.dup.default.should == h.default
    end

    it "should preserve class for subclasses" do
      h = IndifferentHash.new
      h.dup.class.should == h.class
    end
  end
  
  describe "deep_merge" do
    it "should deep merge" do
      hash_1 = HashWithIndifferentAccess.new({ :a => "a", :b => "b", :c => { :c1 => "c1", :c2 => "c2", :c3 => { :d1 => "d1" } } })
      hash_2 = HashWithIndifferentAccess.new({ :a => 1, :c => { :c1 => 2, :c3 => { :d2 => "d2" } } })
      hash_3 = { :a => 1, :c => { :c1 => 2, :c3 => { :d2 => "d2" } } }
      expected = { "a" => 1, "b" => "b", "c" => { "c1" => 2, "c2" => "c2", "c3" => { "d1" => "d1", "d2" => "d2" } } }
      hash_1.deep_merge(hash_2).should == expected
      hash_1.deep_merge(hash_3).should == expected

      hash_1.deep_merge!(hash_2)
      hash_1.should == expected
    end
  end
  
  describe "slice" do
    it "should slice with indiffent keys" do
      original = { :a => 'x', :b => 'y', :c => 10 }.with_indifferent_access
      expected = { :a => 'x', :b => 'y' }.with_indifferent_access

      [['a', 'b'], [:a, :b]].each do |keys|
        # Should return a new hash with only the given keys.
        original.slice(*keys).should == expected
        original.should.not == expected
      end
    end

    it "should silce in place" do
      original = { :a => 'x', :b => 'y', :c => 10 }.with_indifferent_access
      expected = { :c => 10 }.with_indifferent_access

      [['a', 'b'], [:a, :b]].each do |keys|
        # Should replace the hash with only the given keys.
        copy = original.dup
        copy.slice!(*keys).should == expected
      end
    end

    it "should slice sliced hash" do
      original = {'login' => 'bender', 'password' => 'shiny', 'stuff' => 'foo'}
      original = original.with_indifferent_access

      slice = original.slice(:login, :password)

      slice[:login].should == 'bender'
      slice['login'].should == 'bender'
    end
  end
  
  describe "extract!" do
    it "should extract values with indifferent keys" do
      original = {:a => 1, 'b' => 2, :c => 3, 'd' => 4}.with_indifferent_access
      expected = {:a => 1, :b => 2}.with_indifferent_access
      remaining = {:c => 3, :d => 4}.with_indifferent_access

      [['a', 'b'], [:a, :b]].each do |keys|
        copy = original.dup
        copy.extract!(*keys).should == expected
        copy.should == remaining
      end
    end
  end
  
  describe "default value" do
    it "should use the default value for unknown key" do
      hash_wia = HashWithIndifferentAccess.new(3)
      hash_wia[:new_key].should == 3
    end

    it "should use default value if no key is supplied" do
      hash_wia = HashWithIndifferentAccess.new(3)
      hash_wia.default.should == 3
    end

    it "should nil if no default value is supplied" do
      hash_wia = HashWithIndifferentAccess.new
      hash_wia.default.should.be.nil
    end
    
    it "should copy the default value when converting to hash with indifferent access" do
      hash = Hash.new(3)
      hash_wia = hash.with_indifferent_access
      hash_wia.default.should == 3
    end
  end

  describe "fetch" do
    it "should fetch with indifferent access" do
      @strings = @strings.with_indifferent_access

      @strings.fetch('a').should == 1
      @strings.fetch(:a.to_s).should == 1
      @strings.fetch(:a).should == 1
    end
  end

  describe "values_at" do
    it "should return values for multiple keys" do
      @strings = @strings.with_indifferent_access
      @symbols = @symbols.with_indifferent_access
      @mixed   = @mixed.with_indifferent_access
  
      @strings.values_at('a', 'b').should == [1, 2]
      @strings.values_at(:a, :b).should == [1, 2]
      @symbols.values_at('a', 'b').should == [1, 2]
      @symbols.values_at(:a, :b).should == [1, 2]
      @mixed.values_at('a', 'b').should == [1, 2]
      @mixed.values_at(:a, :b).should == [1, 2]
    end
  end

  describe "misc methods" do
    it "should work as expected" do
      @strings = @strings.with_indifferent_access
      @symbols = @symbols.with_indifferent_access
      @mixed   = @mixed.with_indifferent_access

      hashes = { :@strings => @strings, :@symbols => @symbols, :@mixed => @mixed }
      method_map = { :'[]' => 1, :fetch => 1, :values_at => [1],
        :has_key? => true, :include? => true, :key? => true,
        :member? => true }

      hashes.each do |name, hash|
        method_map.sort_by { |m| m.to_s }.each do |meth, expected|
          hash.__send__(meth, 'a').should == expected
          hash.__send__(meth, :a).should == expected
        end
      end
    end
  end
end
