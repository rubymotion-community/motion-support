describe "Time" do
  describe "conversions" do
    describe "to_formatted_s" do
      before do
        @time = Time.utc(2005, 2, 21, 17, 44, 30.12345678901)
      end
      
      it "should use default conversion if no parameter is given" do
        @time.to_s.should == @time.to_default_s
      end
      
      it "should use default conversion if parameter is unknown" do
        @time.to_s(:doesnt_exist).should == @time.to_default_s
      end
      
      it "should convert to db format" do
        @time.to_s(:db).should == "2005-02-21 17:44:30"
      end
      
      it "should convert to short format" do
        @time.to_s(:short).should == "21 Feb 17:44"
      end
      
      it "should convert to time format" do
        @time.to_s(:time).should == "17:44"
      end
      
      it "should convert to number format" do
        @time.to_s(:number).should == "20050221174430"
      end
      
      it "should convert to nsec format" do
        @time.to_s(:nsec).should == "20050221174430123451232"
        # Hmm. Looks like RubyMotion has an issue with nanosecs in string time formatting. It should actually be "20050221174430123456789"
      end
      
      it "should convert to long format" do
        @time.to_s(:long).should == "February 21, 2005 17:44"
      end
      
      it "should convert to long_ordinal format" do
        @time.to_s(:long_ordinal).should == "February 21st, 2005 17:44"
      end
    end
    
    describe "custom date format" do
      it "should convert to custom format" do
        Time::DATE_FORMATS[:custom] = '%Y%m%d%H%M%S'
        Time.local(2005, 2, 21, 14, 30, 0).to_s(:custom).should == '20050221143000'
        Time::DATE_FORMATS.delete(:custom)
      end
    end
  end
end
