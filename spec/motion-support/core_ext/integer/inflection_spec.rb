# These tests are mostly just to ensure that the ordinalize method exists.
# Its results are tested comprehensively in the inflector test cases.
describe "Integer" do
  describe "ordinalize" do
    it "should ordinalize 1" do
      1.ordinalize.should == '1st'
    end
    
    it "should ordinalize 8" do
      8.ordinalize.should == '8th'
    end
  end

  describe "ordinal" do
    it "should get ordinal of 1" do
      1.ordinal.should == 'st'
    end
    
    it "should get ordinal of 8" do
      8.ordinal.should == 'th'
    end
  end
end
