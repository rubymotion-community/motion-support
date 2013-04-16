describe "Time" do
  describe "acts_like" do
    it "should act like time" do
      Time.now.should.acts_like(:time)
    end
    
    it "should not act like date" do
      Time.now.should.not.acts_like(:date)
    end
  end
end
