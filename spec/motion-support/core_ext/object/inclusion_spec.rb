class LifeUniverseAndEverything
  def include?(obj)
    obj == 42
  end
end


describe 'Object' do
  describe "in?" do
    it "should support arrays" do
      1.in?([1,2,3]).should == true
      0.in?([1,2,3]).should == false
    end

    it "should support hashes" do
      :a.in?({a:1,b:2,c:3}).should == true
      1.in?({a:1,b:2,c:3}).should == false
    end

    it "should support ranges" do
      1.in?(1..3).should == true
      0.in?(1..3).should == false
    end

    it "should support strings" do
      'a'.in?("apple").should == true
    end

    it "should support anything that implements `include?`" do
      42.in?(LifeUniverseAndEverything.new).should == true
      0.in?(LifeUniverseAndEverything.new).should == false
    end
  end

  describe "presence_in" do
    it "should return self when included" do
      "stuff".presence_in(%w( lots of stuff )).should == "stuff"
    end

    it "should return nil when not included" do
      "stuff".presence_in(%w( lots of crap )).should == nil
    end

    it "should raise ArgumentError when arg does not respond to `include?`" do
      lambda { 1.presence_in(1) }.should.raise ArgumentError
    end
  end
end
