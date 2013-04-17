class ClassInheritableAccessorBase
  class_inheritable_accessor :empty_accessor
  class_inheritable_accessor :base_accessor, :derived_accessor, :both_accessor
end

class ClassInheritableAccessorDerived < ClassInheritableAccessorBase
end

describe "class inheritable accessor" do
  it "should be accessible in the base class and the derived class" do
    ClassInheritableAccessorBase.respond_to?(:empty_accessor).should == true
    ClassInheritableAccessorDerived.respond_to?(:empty_accessor).should == true
  end
  
  it "should return nil for an unset accessor in the base class" do
    ClassInheritableAccessorBase.empty_accessor.should == nil
  end
  
  it "should return nil for an unset accessor in the derived class" do
    ClassInheritableAccessorDerived.empty_accessor.should == nil
  end
  
  it "should return a value for an accessor set in the base class in the base class" do
    ClassInheritableAccessorBase.base_accessor = 10
    ClassInheritableAccessorBase.base_accessor.should == 10
  end
  
  it "should return a value for an accessor set in the base class in the derived class" do
    ClassInheritableAccessorBase.base_accessor = 10
    ClassInheritableAccessorDerived.base_accessor.should == 10
  end
  
  it "should return nil for the base class if only set for the derived class" do
    ClassInheritableAccessorDerived.derived_accessor = 20
    ClassInheritableAccessorBase.derived_accessor.should == nil
  end
  
  it "should return a value for an accessor set in the derived class in the derived class" do
    ClassInheritableAccessorDerived.derived_accessor = 20
    ClassInheritableAccessorDerived.derived_accessor.should == 20
  end
  
  it "should return different values for base and derived class if both were set independently" do
    ClassInheritableAccessorBase.both_accessor = 30
    ClassInheritableAccessorDerived.both_accessor = 40
    ClassInheritableAccessorBase.both_accessor.should == 30
    ClassInheritableAccessorDerived.both_accessor.should == 40
  end
end
