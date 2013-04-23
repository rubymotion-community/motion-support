describe "String" do
  describe "exclude?" do
    it "should be the inverse of #include" do
      'foo'.exclude?('o').should.be.false
      'foo'.exclude?('p').should.be.true
    end
  end
end
