describe "date" do
  describe "conversions" do
    it "should convert date to string" do
      date = Date.new(2005, 2, 21)
      date.to_s.should == "2005-2-21"
      date.to_s(:short).should == "21 Feb"
      date.to_s(:long).should == "February 21, 2005"
      date.to_s(:long_ordinal).should == "February 21st, 2005"
      date.to_s(:db).should == "2005-02-21"
      date.to_s(:rfc822).should == "21 Feb 2005"
    end
    
    it "should make inspect readable" do
      Date.new(2005, 2, 21).readable_inspect.should == "Mon, 21 Feb 2005"
      Date.new(2005, 2, 21).readable_inspect.should == Date.new(2005, 2, 21).inspect
    end
  end
end
