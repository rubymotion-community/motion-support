describe "Object" do
  before do
    @source = Object.new
    @source.instance_variable_set(:@bar, 'bar')
    @source.instance_variable_set(:@baz, 'baz')
  end
  
  describe "instance_variable_names" do
    it "should return all instance variable names" do
      @source.instance_variable_names.sort.should == %w(@bar @baz)
    end
  end
  
  describe "instance_values" do
    it "should return the values of all instance variables as a hash" do
      @source.instance_values.should == {'bar' => 'bar', 'baz' => 'baz'}
    end
  end
end
