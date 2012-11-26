class ClassInheritableArrayBase
  class_inheritable_array :empty_array
  class_inheritable_array :value_array, :multi_array, :reset_array
  class_inheritable_array :base_array, :derived_array, :both_array
end

class ClassInheritableArrayDerived < ClassInheritableArrayBase
end

describe "class inheritable array" do
  it "should be accessible in the base class and the derived class" do
    ClassInheritableArrayBase.respond_to?(:empty_array).should == true
    ClassInheritableArrayDerived.respond_to?(:empty_array).should == true
  end
  
  it "should return empty array for an unset array in the base class" do
    ClassInheritableArrayBase.empty_array.should == []
  end
  
  it "should return empty array for an unset array in the derived class" do
    ClassInheritableArrayDerived.empty_array.should == []
  end
  
  it "should allow setting array with one value" do
    ClassInheritableArrayBase.value_array = 10
    ClassInheritableArrayBase.value_array.should == [10]
  end
  
  it "should allow setting array with multi values" do
    ClassInheritableArrayBase.multi_array = [10, 20, 30]
    ClassInheritableArrayBase.multi_array.should == [10, 20, 30]
  end
  
  it "should allow resetting array" do
    ClassInheritableArrayBase.reset_array = 10
    ClassInheritableArrayBase.reset_array = 20
    ClassInheritableArrayBase.reset_array.should == [20]
  end
  
  it "should return a value for an array set in the base class in the derived class" do
    ClassInheritableArrayBase.base_array = 10
    ClassInheritableArrayDerived.base_array.should == [10]
  end
  
  it "should return nil for the base class if only set for the derived class" do
    ClassInheritableArrayDerived.derived_array = 20
    ClassInheritableArrayBase.derived_array.should == []
  end
  
  it "should return a value for an array set in the derived class in the derived class" do
    ClassInheritableArrayDerived.derived_array = 20
    ClassInheritableArrayDerived.derived_array.should == [20]
  end
  
  it "should return values from both the base and derived arrays for derived array if both were set independently" do
    ClassInheritableArrayBase.both_array = 30
    ClassInheritableArrayDerived.both_array = 40
    ClassInheritableArrayBase.both_array.should == [30]
    ClassInheritableArrayDerived.both_array.should == [30, 40]
  end
end
