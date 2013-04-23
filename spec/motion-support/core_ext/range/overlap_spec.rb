describe "Range" do
  describe "overlaps?" do
    it "should overlaps last inclusive" do
      (1..5).overlaps?(5..10).should.be.true
    end

    it "should overlaps last exclusive" do
      (1...5).overlaps?(5..10).should.be.false
    end

    it "should overlaps first inclusive" do
      (5..10).overlaps?(1..5).should.be.true
    end

    it "should overlaps first exclusive" do
      (5..10).overlaps?(1...5).should.be.false
    end

    it "should should compare identical inclusive" do
      ((1..10) === (1..10)).should.be.true
    end

    it "should should compare identical exclusive" do
      ((1...10) === (1...10)).should.be.true
    end

    it "should should compare other with exlusive end" do
      ((1..10) === (1...10)).should.be.true
    end

    it "should overlaps on time" do
      time_range_1 = Time.utc(2005, 12, 10, 15, 30)..Time.utc(2005, 12, 10, 17, 30)
      time_range_2 = Time.utc(2005, 12, 10, 17, 00)..Time.utc(2005, 12, 10, 18, 00)
      time_range_1.overlaps?(time_range_2).should.be.true
    end

    it "should no overlaps on time" do
      time_range_1 = Time.utc(2005, 12, 10, 15, 30)..Time.utc(2005, 12, 10, 17, 30)
      time_range_2 = Time.utc(2005, 12, 10, 17, 31)..Time.utc(2005, 12, 10, 18, 00)
      time_range_1.overlaps?(time_range_2).should.be.false
    end
  end
end
