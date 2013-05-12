describe "Kernel" do
  describe "class_eval" do
    it "should delegate to singleton class" do
      o = Object.new
      class << o; @x = 1; end
      o.class_eval { @x }.should == 1
    end
  end
end
