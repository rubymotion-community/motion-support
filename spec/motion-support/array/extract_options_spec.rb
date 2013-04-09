describe 'array options' do
  describe "extract_options!" do
    it "should extract an options hash from an array" do
      [1, 2, :a => :b].extract_options!.should == { :a => :b }
    end
    
    it "should return an empty hash if the last element is not a hash" do
      [1, 2].extract_options!.should == {}
    end
    
    it "should return an empty hash on an empty array" do
      [].extract_options!.should == {}
    end
  end
end
