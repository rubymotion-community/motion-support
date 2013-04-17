describe 'array' do
  describe "wrap" do
    it "should return empty array for nil" do
      Array.wrap(nil).should == []
    end
    
    it "should return unchanged array for array" do
      Array.wrap([1, 2, 3]).should == [1, 2, 3]
    end
    
    it "should not flatten multidimensional array" do
      Array.wrap([[1], [2], [3]]).should == [[1], [2], [3]]
    end
    
    it "should turn simple object into array" do
      Array.wrap(0).should == [0]
    end
  end
end
