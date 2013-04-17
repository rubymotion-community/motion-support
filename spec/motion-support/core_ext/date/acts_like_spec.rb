describe "Date" do
  describe "acts_like" do
    it "should act like date" do
      Date.new.should.acts_like(:date)
    end
    
    it "should not act like time" do
      Date.new.should.not.acts_like(:time)
    end
  end
end
