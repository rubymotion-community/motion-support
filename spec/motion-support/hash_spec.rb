describe "hash" do
  describe "empty?" do
    it "reports an empty hash using empty?" do
      {:key => 'value'}.empty?.should.not.be.true
      {}.empty?.should.be.true
    end
  end
  
  describe "except" do
    it "creates sub-hashes using except" do
      {:a => 'a', :b => 'b'}.except(:b)[:b].should.be.nil
      {:a => 'a', :b => 'b'}.except(:b).length.should == 1
    end
  end
end
