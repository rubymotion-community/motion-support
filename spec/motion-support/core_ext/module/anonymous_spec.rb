describe "module" do
  describe "anonymous?" do
    it "should return true for an anonymous module" do
      Module.new.anonymous?.should == true
    end
    
    it "should return true for an anonymous class" do
      Class.new.anonymous?.should == true
    end
    
    it "should return false for a named module" do
      Kernel.anonymous?.should == false
    end
    
    it "should return false for a named class" do
      Object.anonymous?.should == false
    end
    
    it "should return false for module that acquired a name" do
      NamedModule = Module.new
      NamedModule.anonymous?.should == false
    end
    
    it "should return false for module that acquired a name" do
      NamedClass = Class.new
      NamedClass.anonymous?.should == false
    end
  end
end
