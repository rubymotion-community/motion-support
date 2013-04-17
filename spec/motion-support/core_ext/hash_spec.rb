describe "hash" do
  describe "empty?" do
    it "reports an empty hash using empty?" do
      {:key => 'value'}.empty?.should.not.be.true
      {}.empty?.should.be.true
    end
  end
end
