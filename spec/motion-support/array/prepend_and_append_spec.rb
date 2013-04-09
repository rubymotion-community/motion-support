describe 'array' do
  describe "prepend" do
    it "should add an element to the front of the array" do
      [1, 2, 3].prepend(0).should == [0, 1, 2, 3]
    end
    
    it "should change the array" do
      array = [1, 2, 3]
      array.prepend(0)
      array.should == [0, 1, 2, 3]
    end
  end
  
  describe "append" do
    it "should add an element to the back of the array" do
      [1, 2, 3].append(4).should == [1, 2, 3, 4]
    end
    
    it "should change the array" do
      array = [1, 2, 3]
      array.append(4)
      array.should == [1, 2, 3, 4]
    end
  end
end
