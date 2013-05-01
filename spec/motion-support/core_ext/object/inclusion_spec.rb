class LifeUniverseAndEverything
  def include?(obj)
    obj == 42
  end
end


describe 'array' do
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
end
