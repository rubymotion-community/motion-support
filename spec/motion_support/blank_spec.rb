describe "blank" do
  describe "Object" do
    it "should be blank when responds to empty and is empty" do
      [].respond_to?(:empty?).should == true
      [].blank?.should == true
    end
    
    it "should not be blank when responds to empty and is not empty" do
      "Teststring".respond_to?(:empty?).should == true
      "Teststring".blank?.should == false
    end
    
    it "should be present if not blank" do
      "Hello".present?.should == true
    end
    
    it "should not be present if blank" do
      [].present?.should == false
    end
  end
  
  describe "common objects" do
    it "should be blank for empty array" do
      [].blank?.should == true
    end
    
    it "should be blank for empty string" do
      "".blank?.should == true
    end
    
    it "should be blank for empty hash" do
      {}.blank?.should == true
    end
  end
  
  describe "Nil" do
    it "should always be blank" do
      nil.blank?.should == true
    end
  end
end
