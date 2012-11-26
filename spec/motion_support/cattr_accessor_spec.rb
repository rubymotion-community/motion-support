class CAttrAccessorBase
  cattr_accessor :empty_accessor
  cattr_accessor :base_accessor, :derived_accessor, :both_accessor
end

class CAttrAccessorDerived < CAttrAccessorBase
end

describe "cattr accessor" do
  it "should be accessible in the base class and the derived class" do
    CAttrAccessorBase.respond_to?(:empty_accessor).should == true
    CAttrAccessorDerived.respond_to?(:empty_accessor).should == true
  end
  
  it "should return nil for an unset accessor in the base class" do
    CAttrAccessorBase.empty_accessor.should == nil
  end
  
  it "should return nil for an unset accessor in the derived class" do
    CAttrAccessorDerived.empty_accessor.should == nil
  end
  
  it "should return a value for an accessor set in the base class in the base class" do
    CAttrAccessorBase.base_accessor = 10
    CAttrAccessorBase.base_accessor.should == 10
  end
  
  it "should return nil for an accessor set in the base class in the derived class" do
    CAttrAccessorBase.base_accessor = 10
    CAttrAccessorDerived.base_accessor.should == nil
  end
  
  it "should return nil for the base class if set for the derived class" do
    CAttrAccessorDerived.derived_accessor = 20
    CAttrAccessorBase.derived_accessor.should == nil
  end
  
  it "should return a value for an accessor set in the derived class in the derived class" do
    CAttrAccessorDerived.derived_accessor = 20
    CAttrAccessorDerived.derived_accessor.should == 20
  end
  
  it "should return different values for base and derived class if both were set independently" do
    CAttrAccessorBase.both_accessor = 30
    CAttrAccessorDerived.both_accessor = 40
    CAttrAccessorBase.both_accessor.should == 30
    CAttrAccessorDerived.both_accessor.should == 40
  end
end
