PRIME = 22953686867719691230002707821868552601124472329079

describe "Integer" do
  describe "multiple_of" do
    it "should determine if an integer is a multiple of another" do
      [ -7, 0, 7, 14 ].each { |i| i.should.be.multiple_of 7 }
      [ -7, 7, 14 ].each { |i| i.should.not.be.multiple_of 6 }
    end
    
    it "should work with edge cases" do
      0.should.be.multiple_of 0
      5.should.not.be.multiple_of 0
    end

    it "should work with a prime" do
      [2, 3, 5, 7].each { |i| PRIME.should.not.be.multiple_of i }
    end
  end
end
