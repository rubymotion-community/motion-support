describe "deep_dup" do
  describe "array" do
    it "should deep_dup nested array" do
      array = [1, [2, 3]]
      dup = array.deep_dup
      dup[1][2] = 4
      array[1][2].should.be.nil
      dup[1][2].should == 4
    end
    
    it "should deep_dup array with hash inside" do
      array = [1, { :a => 2, :b => 3 } ]
      dup = array.deep_dup
      dup[1][:c] = 4
      array[1][:c].should.be.nil
      dup[1][:c].should == 4
    end
  end
  
  describe "hash" do
    it "should deep_dup nested hash" do
      hash = { :a => { :b => 'b' } }
      dup = hash.deep_dup
      dup[:a][:c] = 'c'
      hash[:a][:c].should.be.nil
      dup[:a][:c].should == 'c'
    end
    
    it "should deep_dup hash with array inside" do
      hash = { :a => [1, 2] }
      dup = hash.deep_dup
      dup[:a][2] = 'c'
      hash[:a][2].should.be.nil
      dup[:a][2].should == 'c'
    end
    
    it "should deep_dup hash with init value" do
      zero_hash = Hash.new 0
      hash = { :a => zero_hash }
      dup = hash.deep_dup
      dup[:a][44].should == 0
    end
  end
  
  describe "Object" do
    it "should deep_dup object" do
      object = Object.new
      dup = object.deep_dup
      dup.instance_variable_set(:@a, 1)
      object.should.not.be.instance_variable_defined(:@a)
      dup.should.be.instance_variable_defined(:@a)
    end
  end
end
