describe "hash" do
  describe "slice" do
    it "should return a new hash with only the given keys" do
      original = { :a => 'x', :b => 'y', :c => 10 }
      expected = { :a => 'x', :b => 'y' }

      original.slice(:a, :b).should == expected
      original.should.not == expected
    end
    
    it "should replace the hash with only the given keys" do
      original = { :a => 'x', :b => 'y', :c => 10 }
      expected = { :c => 10 }

      original.slice!(:a, :b).should == expected
    end
    
    it "should return a new hash with only the given keys when given an array key" do
      original = { :a => 'x', :b => 'y', :c => 10, [:a, :b] => "an array key" }
      expected = { [:a, :b] => "an array key", :c => 10 }

      original.slice([:a, :b], :c).should == expected
      original.should.not == expected
    end

    it "should replace the hash with only the given keys when given an array key" do
      original = { :a => 'x', :b => 'y', :c => 10, [:a, :b] => "an array key" }
      expected = { :a => 'x', :b => 'y' }

      original.slice!([:a, :b], :c).should == expected
    end

    it "should grab each of the splatted keys" do
      original = { :a => 'x', :b => 'y', :c => 10, [:a, :b] => "an array key" }
      expected = { :a => 'x', :b => "y" }

      original.slice(*[:a, :b]).should == expected
    end
  end
  
  describe "extract!" do
    it "should extract subhash" do
      original = {:a => 1, :b => 2, :c => 3, :d => 4}
      expected = {:a => 1, :b => 2}
      remaining = {:c => 3, :d => 4}

      original.extract!(:a, :b, :x).should == expected
      original.should == remaining
    end

    it "should extract nils" do
      original = {:a => nil, :b => nil}
      expected = {:a => nil}
      extracted = original.extract!(:a, :x)

      extracted.should == expected
      extracted[:a].should == nil
      extracted[:x].should == nil
    end
  end
end
