describe "hash" do
  describe "except" do
    it "should remove key" do
      original = { :a => 'x', :b => 'y', :c => 10 }
      expected = { :a => 'x', :b => 'y' }

      original.except(:c).should == expected
      original.should.not == expected
    end
    
    it "should remove more than one key" do
      original = { :a => 'x', :b => 'y', :c => 10 }
      expected = { :a => 'x' }
      original.except(:b, :c).should == expected
    end
    
    it "should work on frozen hash" do
      original = { :a => 'x', :b => 'y' }
      original.freeze
      lambda { original.except(:a) }.should.not.raise
    end
  end
  
  describe "except!" do
    it "should remove key in place" do
      original = { :a => 'x', :b => 'y', :c => 10 }
      expected = { :a => 'x', :b => 'y' }

      original.should.not == expected
      original.except!(:c).should == expected
      original.should == expected
    end
    
    it "should remove more than one key in place" do
      original = { :a => 'x', :b => 'y', :c => 10 }
      expected = { :a => 'x' }

      original.should.not == expected
      original.except!(:b, :c).should == expected
      original.should == expected
    end
  end
end
