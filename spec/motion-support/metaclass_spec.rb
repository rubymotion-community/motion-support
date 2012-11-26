describe "metaclass" do
  it "should return the metaclass for a class" do
    String.metaclass.is_a?(Class).should == true
  end
  
  it "should return the metaclass for an object" do
    "string".metaclass.is_a?(Class).should == true
  end
end
