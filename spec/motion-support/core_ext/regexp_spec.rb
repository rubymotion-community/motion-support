describe "Regexp" do
  it "should find out if regexp is multiline" do
    //m.multiline?.should.be.true
    //.multiline?.should.be.false
    /(?m:)/.multiline?.should.be.false
  end
end
