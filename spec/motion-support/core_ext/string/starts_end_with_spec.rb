describe "String" do
  describe "starts_with?/ends_with?" do
    it "should have starts/ends_with? alias" do
      s = "hello"
      s.starts_with?('h').should.be.true
      s.starts_with?('hel').should.be.true
      s.starts_with?('el').should.be.false

      s.ends_with?('o').should.be.true
      s.ends_with?('lo').should.be.true
      s.ends_with?('el').should.be.false
    end
  end
end
