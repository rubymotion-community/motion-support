describe "Range" do
  describe "include?" do
    it "should should include identical inclusive" do
      (1..10).should.include(1..10)
    end

    it "should should include identical exclusive" do
      (1...10).should.include(1...10)
    end

    it "should should include other with exlusive end" do
      (1..10).should.include(1...10)
    end

    it "should exclusive end should not include identical with inclusive end" do
      (1...10).should.not.include(1..10)
    end

    it "should should not include overlapping first" do
      (2..8).should.not.include(1..3)
    end

    it "should should not include overlapping last" do
      (2..8).should.not.include(5..9)
    end

    it "should should include identical exclusive with floats" do
      (1.0...10.0).should.include(1.0...10.0)
    end
  end
end
