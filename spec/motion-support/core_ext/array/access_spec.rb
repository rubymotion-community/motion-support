describe 'array access' do
  describe "from" do
    it "should return the tail of an array from position" do
      ['a', 'b', 'c', 'd'].from(0).should == ["a", "b", "c", "d"]
      ['a', 'b', 'c', 'd'].from(2).should == ["c", "d"]
      ['a', 'b', 'c', 'd'].from(10).should == []
      [].from(0).should == []
    end
  end
  
  describe "to" do
    it "should return the head of an array up to position" do
      ['a', 'b', 'c', 'd'].to(0).should == ["a"]
      ['a', 'b', 'c', 'd'].to(2).should == ["a", "b", "c"]
      ['a', 'b', 'c', 'd'].to(10).should == ["a", "b", "c", "d"]
      [].to(0).should == []
    end
  end
  
  describe "second" do
    it "should return the second element in an array" do
      ['a', 'b', 'c', 'd'].second.should == 'b'
    end
    
    it "should return nil if there is no second element" do
      [].second.should == nil
    end
  end
end
