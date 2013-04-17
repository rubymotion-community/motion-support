describe "Time" do
  describe "calculations" do
    describe "seconds_since_midnight" do
      it "should calculate correctly" do
        Time.local(2005,1,1,0,0,1).seconds_since_midnight.should == 1
        Time.local(2005,1,1,0,1,0).seconds_since_midnight.should == 60
        Time.local(2005,1,1,1,1,0).seconds_since_midnight.should == 3660
        Time.local(2005,1,1,23,59,59).seconds_since_midnight.should == 86399
        Time.local(2005,1,1,0,1,0,10).seconds_since_midnight.should == 60.00001
      end
    end
    
    describe "seconds_until_end_of_day" do
      it "should calculate correctly" do
        Time.local(2005,1,1,23,59,59).seconds_until_end_of_day.should == 0
        Time.local(2005,1,1,23,59,58).seconds_until_end_of_day.should == 1
        Time.local(2005,1,1,23,58,59).seconds_until_end_of_day.should == 60
        Time.local(2005,1,1,22,58,59).seconds_until_end_of_day.should == 3660
        Time.local(2005,1,1,0,0,0).seconds_until_end_of_day.should == 86399
      end
    end
    
    describe "beginning_of_day" do
      it "should calculate correctly" do
        Time.local(2005,2,4,10,10,10).beginning_of_day.should == Time.local(2005,2,4,0,0,0)
      end
    end
    
    describe "beginning_of_hour" do
      it "should calculate correctly" do
        Time.local(2005,2,4,19,30,10).beginning_of_hour.should == Time.local(2005,2,4,19,0,0)
      end
    end
    
    describe "beginning_of_minute" do
      it "should calculate correctly" do
        Time.local(2005,2,4,19,30,10).beginning_of_minute.should == Time.local(2005,2,4,19,30,0)
      end
    end
    
    describe "end_of_day" do
      it "should calculate correctly" do
        Time.local(2007,8,12,10,10,10).end_of_day.should == Time.local(2007,8,12,23,59,59,Rational(999999999, 1000))
      end
    end
    
    describe "end_of_hour" do
      it "should calculate correctly" do
        Time.local(2005,2,4,19,30,10).end_of_hour.should == Time.local(2005,2,4,19,59,59,Rational(999999999, 1000))
      end
    end
    
    describe "end_of_minute" do
      it "should calculate correctly" do
        Time.local(2005,2,4,19,30,10).end_of_minute.should == Time.local(2005,2,4,19,30,59,Rational(999999999, 1000))
      end
    end
    
    describe "last_year" do
      it "should calculate correctly" do
        Time.local(2005,6,5,10,0,0).last_year.should == Time.local(2004,6,5,10)
      end
    end
    
    describe "ago" do
      it "should calculate correctly" do
        Time.local(2005,2,22,10,10,10).ago(1).should == Time.local(2005,2,22,10,10,9)
        Time.local(2005,2,22,10,10,10).ago(3600).should == Time.local(2005,2,22,9,10,10)
        Time.local(2005,2,22,10,10,10).ago(86400*2).should == Time.local(2005,2,20,10,10,10)
        Time.local(2005,2,22,10,10,10).ago(86400*2 + 3600 + 25).should == Time.local(2005,2,20,9,9,45)
      end
    end
    
    describe "since" do
      it "should calculate correctly" do
        Time.local(2005,2,22,10,10,10).since(1).should == Time.local(2005,2,22,10,10,11)
        Time.local(2005,2,22,10,10,10).since(3600).should == Time.local(2005,2,22,11,10,10)
        Time.local(2005,2,22,10,10,10).since(86400*2).should == Time.local(2005,2,24,10,10,10)
        Time.local(2005,2,22,10,10,10).since(86400*2 + 3600 + 25).should == Time.local(2005,2,24,11,10,35)
      end
    end
    
    describe "change" do
      it "should calculate correctly" do
        Time.local(2005,2,22,15,15,10).change(:year => 2006).should == Time.local(2006,2,22,15,15,10)
        Time.local(2005,2,22,15,15,10).change(:month => 6).should == Time.local(2005,6,22,15,15,10)
        Time.local(2005,2,22,15,15,10).change(:year => 2012, :month => 9).should == Time.local(2012,9,22,15,15,10)
        Time.local(2005,2,22,15,15,10).change(:hour => 16).should == Time.local(2005,2,22,16)
        Time.local(2005,2,22,15,15,10).change(:hour => 16, :min => 45).should == Time.local(2005,2,22,16,45)
        Time.local(2005,2,22,15,15,10).change(:min => 45).should == Time.local(2005,2,22,15,45)

        Time.local(2005,1,2,11,22,33,44).change(:hour => 5).should == Time.local(2005,1,2,5,0,0,0)
        Time.local(2005,1,2,11,22,33,44).change(:min => 6).should == Time.local(2005,1,2,11,6,0,0)
        Time.local(2005,1,2,11,22,33,44).change(:sec => 7).should == Time.local(2005,1,2,11,22,7,0)
        Time.local(2005,1,2,11,22,33,44).change(:usec => 8).should == Time.local(2005,1,2,11,22,33,8)
      end
    end
    
    describe "advance" do
      it "should calculate correctly" do
        Time.local(2005,2,28,15,15,10).advance(:years => 1).should == Time.local(2006,2,28,15,15,10)
        Time.local(2005,2,28,15,15,10).advance(:months => 4).should == Time.local(2005,6,28,15,15,10)
        Time.local(2005,2,28,15,15,10).advance(:weeks => 3).should == Time.local(2005,3,21,15,15,10)
        Time.local(2005,2,28,15,15,10).advance(:weeks => 3.5).should == Time.local(2005,3,25,3,15,10)
        Time.local(2005,2,28,15,15,10).advance(:days => 5).should == Time.local(2005,3,5,15,15,10)
        Time.local(2005,2,28,15,15,10).advance(:days => 5.5).should == Time.local(2005,3,6,3,15,10)
        Time.local(2005,2,28,15,15,10).advance(:years => 7, :months => 7).should == Time.local(2012,9,28,15,15,10)
        Time.local(2005,2,28,15,15,10).advance(:years => 7, :months => 19, :days => 5).should == Time.local(2013,10,3,15,15,10)
        Time.local(2005,2,28,15,15,10).advance(:years => 7, :months => 19, :weeks => 2, :days => 5).should == Time.local(2013,10,17,15,15,10)
        Time.local(2005,2,28,15,15,10).advance(:years => -3, :months => -2, :days => -1).should == Time.local(2001,12,27,15,15,10)
        Time.local(2004,2,29,15,15,10).advance(:years => 1).should == Time.local(2005,2,28,15,15,10)
        Time.local(2005,2,28,15,15,10).advance(:hours => 5).should == Time.local(2005,2,28,20,15,10)
        Time.local(2005,2,28,15,15,10).advance(:minutes => 7).should == Time.local(2005,2,28,15,22,10)
        Time.local(2005,2,28,15,15,10).advance(:seconds => 9).should == Time.local(2005,2,28,15,15,19)
        Time.local(2005,2,28,15,15,10).advance(:hours => 5, :minutes => 7, :seconds => 9).should == Time.local(2005,2,28,20,22,19)
        Time.local(2005,2,28,15,15,10).advance(:hours => -5, :minutes => -7, :seconds => -9).should == Time.local(2005,2,28,10,8,1)
        Time.local(2005,2,28,15,15,10).advance(:years => 7, :months => 19, :weeks => 2, :days => 5, :hours => 5, :minutes => 7, :seconds => 9).should == Time.local(2013,10,17,20,22,19)
      end
      
      it "should advance with nsec" do
        t = Time.at(0, Rational(108635108, 1000))
        t.advance(:months => 0).should == t
      end
    end
    
    describe "days_in_month" do
      it "should calculate with year" do
        Time.days_in_month(1, 2005).should == 31

        Time.days_in_month(2, 2005).should == 28
        Time.days_in_month(2, 2004).should == 29
        Time.days_in_month(2, 2000).should == 29
        Time.days_in_month(2, 1900).should == 28

        Time.days_in_month(3, 2005).should == 31
        Time.days_in_month(4, 2005).should == 30
        Time.days_in_month(5, 2005).should == 31
        Time.days_in_month(6, 2005).should == 30
        Time.days_in_month(7, 2005).should == 31
        Time.days_in_month(8, 2005).should == 31
        Time.days_in_month(9, 2005).should == 30
        Time.days_in_month(10, 2005).should == 31
        Time.days_in_month(11, 2005).should == 30
        Time.days_in_month(12, 2005).should == 31
      end
      
      it "should calculate for february in common year" do
        Time.days_in_month(2, 2007).should == 28
      end
      
      it "should calculate for february in leap year" do
        Time.days_in_month(2, 2008).should == 29
      end
    end
    
    describe "last_month" do
      it "should work on the 31st" do
        Time.local(2004, 3, 31).last_month.should == Time.local(2004, 2, 29)
      end
    end
    
    describe "<=>" do
      it "should compare with time" do
        (Time.utc(2000) <=> Time.utc(1999, 12, 31, 23, 59, 59, 999)).should == 1
        (Time.utc(2000) <=> Time.utc(2000, 1, 1, 0, 0, 0)).should == 0
        (Time.utc(2000) <=> Time.utc(2000, 1, 1, 0, 0, 0, 001)).should == -1
      end
    end
    
    describe "all_day" do
      it "should calculate correctly" do
        Time.local(2011,6,7,10,10,10).all_day.should == (Time.local(2011,6,7,0,0,0)..Time.local(2011,6,7,23,59,59,Rational(999999999, 1000)))
      end
    end
    
    describe "all_week" do
      it "should calculate correctly" do
        Time.local(2011,6,7,10,10,10).all_week.should == (Time.local(2011,6,6,0,0,0)..Time.local(2011,6,12,23,59,59,Rational(999999999, 1000)))
        Time.local(2011,6,7,10,10,10).all_week(:sunday).should == (Time.local(2011,6,5,0,0,0)..Time.local(2011,6,11,23,59,59,Rational(999999999, 1000)))
      end
    end
    
    describe "all_month" do
      it "should calculate correctly" do
        Time.local(2011,6,7,10,10,10).all_month.should == (Time.local(2011,6,1,0,0,0)..Time.local(2011,6,30,23,59,59,Rational(999999999, 1000)))
      end
    end
    
    describe "all_quarter" do
      it "should calculate correctly" do
        Time.local(2011,6,7,10,10,10).all_quarter.should == (Time.local(2011,4,1,0,0,0)..Time.local(2011,6,30,23,59,59,Rational(999999999, 1000)))
      end
    end
    
    describe "all_year" do
      it "should calculate correctly" do
        Time.local(2011,6,7,10,10,10).all_year.should == (Time.local(2011,1,1,0,0,0)..Time.local(2011,12,31,23,59,59,Rational(999999999, 1000)))
      end
    end
  end
end
