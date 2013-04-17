class Date
  def self.for_spec(year, month, day, hour, minute, second, usec)
    new(year, month, day)
  end
end

class Time
  def self.for_spec(year, month, day, hour, minute, second, usec)
    local(year, month, day, hour, minute, second, usec)
  end
end

[Date, Time].each do |klass|
  describe klass do
    @klass = klass
    def date_or_time(year, month, day, hour, minute, second, usec = nil)
      @klass.for_spec(year, month, day, hour, minute, second, usec)
    end
    
    def with_bw_default(bw = :monday)
      old_bw = Date.beginning_of_week
      Date.beginning_of_week = bw
      yield
    ensure
      Date.beginning_of_week = old_bw
    end
    
    describe "yesterday" do
      it "should be calculated correctly" do
        date_or_time(2005,2,22,10,10,10).yesterday.should == date_or_time(2005,2,21,10,10,10)
        date_or_time(2005,3,2,10,10,10).yesterday.yesterday.should == date_or_time(2005,2,28,10,10,10)
      end
    end
    
    describe "tomorrow" do
      it "should be calculated correctly" do
        date_or_time(2005,2,22,10,10,10).tomorrow.should == date_or_time(2005,2,23,10,10,10)
        date_or_time(2005,2,28,10,10,10).tomorrow.tomorrow.should == date_or_time(2005,3,2,10,10,10)
      end
    end
    
    describe "days_ago" do
      it "should be calculated correctly" do
        date_or_time(2005,6,5,10,10,10).days_ago(1).should == date_or_time(2005,6,4,10,10,10)
        date_or_time(2005,6,5,10,10,10).days_ago(5).should == date_or_time(2005,5,31,10,10,10)
      end
    end
    
    describe "days_since" do
      it "should be calculated correctly" do
        date_or_time(2005,6,5,10,10,10).days_since(1).should == date_or_time(2005,6,6,10,10,10)
        date_or_time(2004,12,31,10,10,10).days_since(1).should == date_or_time(2005,1,1,10,10,10)
      end
    end
    
    describe "weeks_ago" do
      it "should be calculated correctly" do
        date_or_time(2005,6,5,10,10,10).weeks_ago(1).should == date_or_time(2005,5,29,10,10,10)
        date_or_time(2005,6,5,10,10,10).weeks_ago(5).should == date_or_time(2005,5,1,10,10,10)
        date_or_time(2005,6,5,10,10,10).weeks_ago(6).should == date_or_time(2005,4,24,10,10,10)
        date_or_time(2005,6,5,10,10,10).weeks_ago(14).should == date_or_time(2005,2,27,10,10,10)
        date_or_time(2005,1,1,10,10,10).weeks_ago(1).should == date_or_time(2004,12,25,10,10,10)
      end
    end
    
    describe "weeks_since" do
      it "should be calculated correctly" do
        date_or_time(2005,7,7,10,10,10).weeks_since(1).should == date_or_time(2005,7,14,10,10,10)
        date_or_time(2005,7,7,10,10,10).weeks_since(1).should == date_or_time(2005,7,14,10,10,10)
        date_or_time(2005,6,27,10,10,10).weeks_since(1).should == date_or_time(2005,7,4,10,10,10)
        date_or_time(2004,12,28,10,10,10).weeks_since(1).should == date_or_time(2005,1,4,10,10,10)
      end
    end
    
    describe "months_ago" do
      it "should be calculated correctly" do
        date_or_time(2005,6,5,10,10,10).months_ago(1).should == date_or_time(2005,5,5,10,10,10)
        date_or_time(2005,6,5,10,10,10).months_ago(7).should == date_or_time(2004,11,5,10,10,10)
        date_or_time(2005,6,5,10,10,10).months_ago(6).should == date_or_time(2004,12,5,10,10,10)
        date_or_time(2005,6,5,10,10,10).months_ago(12).should == date_or_time(2004,6,5,10,10,10)
        date_or_time(2005,6,5,10,10,10).months_ago(24).should == date_or_time(2003,6,5,10,10,10)
      end
    end
    
    describe "months_since" do
      it "should be calculated correctly" do
        date_or_time(2005,6,5,10,10,10).months_since(1).should == date_or_time(2005,7,5,10,10,10)
        date_or_time(2005,12,5,10,10,10).months_since(1).should == date_or_time(2006,1,5,10,10,10)
        date_or_time(2005,6,5,10,10,10).months_since(6).should == date_or_time(2005,12,5,10,10,10)
        date_or_time(2005,12,5,10,10,10).months_since(6).should == date_or_time(2006,6,5,10,10,10)
        date_or_time(2005,6,5,10,10,10).months_since(7).should == date_or_time(2006,1,5,10,10,10)
        date_or_time(2005,6,5,10,10,10).months_since(12).should == date_or_time(2006,6,5,10,10,10)
        date_or_time(2005,6,5,10,10,10).months_since(24).should == date_or_time(2007,6,5,10,10,10)
        date_or_time(2005,3,31,10,10,10).months_since(1).should == date_or_time(2005,4,30,10,10,10)
        date_or_time(2005,1,29,10,10,10).months_since(1).should == date_or_time(2005,2,28,10,10,10)
        date_or_time(2005,1,30,10,10,10).months_since(1).should == date_or_time(2005,2,28,10,10,10)
        date_or_time(2005,1,31,10,10,10).months_since(1).should == date_or_time(2005,2,28,10,10,10)
      end
    end
    
    describe "years_ago" do
      it "should be calculated correctly" do
        date_or_time(2005,6,5,10,10,10).years_ago(1).should == date_or_time(2004,6,5,10,10,10)
        date_or_time(2005,6,5,10,10,10).years_ago(7).should == date_or_time(1998,6,5,10,10,10)
         # 1 year ago from leap day
        date_or_time(2004,2,29,10,10,10).years_ago(1).should == date_or_time(2003,2,28,10,10,10)
      end
    end
    
    describe "years_since" do
      it "should be calculated correctly" do
        date_or_time(2005,6,5,10,10,10).years_since(1).should == date_or_time(2006,6,5,10,10,10)
        date_or_time(2005,6,5,10,10,10).years_since(7).should == date_or_time(2012,6,5,10,10,10)
        # 1 year since leap day
        date_or_time(2004,2,29,10,10,10).years_since(1).should == date_or_time(2005,2,28,10,10,10)
      end
    end
    
    describe "beginning_of_month" do
      it "should be calculated correctly" do
        date_or_time(2005,2,22,10,10,10).beginning_of_month.should == date_or_time(2005,2,1,0,0,0)
      end
    end
    
    describe "beginning_of_quarter" do
      it "should be calculated correctly" do
        date_or_time(2005,2,15,10,10,10).beginning_of_quarter.should == date_or_time(2005,1,1,0,0,0)
        date_or_time(2005,1,1,0,0,0).beginning_of_quarter.should == date_or_time(2005,1,1,0,0,0)
        date_or_time(2005,12,31,10,10,10).beginning_of_quarter.should == date_or_time(2005,10,1,0,0,0)
        date_or_time(2005,6,30,23,59,59).beginning_of_quarter.should == date_or_time(2005,4,1,0,0,0)
      end
    end
    
    describe "end_of_quarter" do
      it "should be calculated correctly" do
        date_or_time(2007,2,15,10,10,10).end_of_quarter.should == date_or_time(2007,3,31,23,59,59,Rational(999999999, 1000))
        date_or_time(2007,3,31,0,0,0).end_of_quarter.should == date_or_time(2007,3,31,23,59,59,Rational(999999999, 1000))
        date_or_time(2007,12,21,10,10,10).end_of_quarter.should == date_or_time(2007,12,31,23,59,59,Rational(999999999, 1000))
        date_or_time(2007,4,1,0,0,0).end_of_quarter.should == date_or_time(2007,6,30,23,59,59,Rational(999999999, 1000))
        date_or_time(2008,5,31,0,0,0).end_of_quarter.should == date_or_time(2008,6,30,23,59,59,Rational(999999999, 1000))
      end
    end
    
    describe "beginning_of_year" do
      it "should be calculated correctly" do
        date_or_time(2005,2,22,10,10,10).beginning_of_year.should == date_or_time(2005,1,1,0,0,0)
      end
    end
    
    describe "next_week" do
      it "should be calculated correctly" do
        date_or_time(2005,2,22,15,15,10).next_week.should == date_or_time(2005,2,28,0,0,0)
        date_or_time(2005,2,22,15,15,10).next_week(:friday).should == date_or_time(2005,3,4,0,0,0)
        date_or_time(2006,10,23,0,0,0).next_week.should == date_or_time(2006,10,30,0,0,0)
        date_or_time(2006,10,23,0,0,0).next_week(:wednesday).should == date_or_time(2006,11,1,0,0,0)
      end
      
      it "should be calculated correctly with default beginning of week" do
        # calling with_bw_default produces LocalJumpError, even though a block is given
        begin
          old_bw = Date.beginning_of_week
          Date.beginning_of_week = :tuesday
        
          date_or_time(2012,3,21,0,0,0).next_week(:wednesday).should == date_or_time(2012,3,28,0,0,0)
          date_or_time(2012,3,21,0,0,0).next_week(:saturday).should == date_or_time(2012,3,31,0,0,0)
          date_or_time(2012,3,21,0,0,0).next_week(:tuesday).should == date_or_time(2012,3,27,0,0,0)
          date_or_time(2012,3,21,0,0,0).next_week(:monday).should == date_or_time(2012,4,02,0,0,0)
        ensure
          Date.beginning_of_week = old_bw
        end
      end
    end
    
    describe "next_month" do
      it "should be calculated correctly" do
        date_or_time(2005,8,31,15,15,10).next_month.should == date_or_time(2005,9,30,15,15,10)
      end
    end
    
    describe "next_quarter" do
      it "should be calculated correctly" do
        date_or_time(2005,8,31,15,15,10).next_quarter.should == date_or_time(2005,11,30,15,15,10)
      end
    end
    
    describe "next_year" do
      it "should be calculated correctly" do
        date_or_time(2005,6,5,10,10,10).next_year.should == date_or_time(2006,6,5,10,10,10)
      end
    end
    
    describe "prev_week" do
      it "should be calculated correctly" do
        date_or_time(2005,3,1,15,15,10).prev_week.should == date_or_time(2005,2,21,0,0,0)
        date_or_time(2005,3,1,15,15,10).prev_week(:tuesday).should == date_or_time(2005,2,22,0,0,0)
        date_or_time(2005,3,1,15,15,10).prev_week(:friday).should == date_or_time(2005,2,25,0,0,0)
        date_or_time(2006,11,6,0,0,0).prev_week.should == date_or_time(2006,10,30,0,0,0)
        date_or_time(2006,11,23,0,0,0).prev_week(:wednesday).should == date_or_time(2006,11,15,0,0,0)
      end
      
      it "should be calculated correctly with default beginning of week" do
        begin
          old_bw = Date.beginning_of_week
          Date.beginning_of_week = :tuesday
        
          date_or_time(2012,3,21,0,0,0).prev_week(:wednesday).should == date_or_time(2012,3,14,0,0,0)
          date_or_time(2012,3,21,0,0,0).prev_week(:saturday).should == date_or_time(2012,3,17,0,0,0)
          date_or_time(2012,3,21,0,0,0).prev_week(:tuesday).should == date_or_time(2012,3,13,0,0,0)
          date_or_time(2012,3,21,0,0,0).prev_week(:monday).should == date_or_time(2012,3,19,0,0,0)
        ensure
          Date.beginning_of_week = old_bw
        end
      end
    end
    
    describe "prev_month" do
      it "should be calculated correctly" do
        date_or_time(2004,3,31,10,10,10).prev_month.should == date_or_time(2004,2,29,10,10,10)
      end
    end
    
    describe "prev_quarter" do
      it "should be calculated correctly" do
        date_or_time(2004,5,31,10,10,10).prev_quarter.should == date_or_time(2004,2,29,10,10,10)
      end
    end
    
    describe "prev_year" do
      it "should be calculated correctly" do
        date_or_time(2005,6,5,10,10,10).prev_year.should == date_or_time(2004,6,5,10,10,10)
      end
    end
    
    describe "days_to_week_start" do
      it "should be calculated correctly" do
        date_or_time(2011,11,01,0,0,0).days_to_week_start(:tuesday).should == 0
        date_or_time(2011,11,02,0,0,0).days_to_week_start(:tuesday).should == 1
        date_or_time(2011,11,03,0,0,0).days_to_week_start(:tuesday).should == 2
        date_or_time(2011,11,04,0,0,0).days_to_week_start(:tuesday).should == 3
        date_or_time(2011,11,05,0,0,0).days_to_week_start(:tuesday).should == 4
        date_or_time(2011,11,06,0,0,0).days_to_week_start(:tuesday).should == 5
        date_or_time(2011,11,07,0,0,0).days_to_week_start(:tuesday).should == 6

        date_or_time(2011,11,03,0,0,0).days_to_week_start(:monday).should == 3
        date_or_time(2011,11,04,0,0,0).days_to_week_start(:tuesday).should == 3
        date_or_time(2011,11,05,0,0,0).days_to_week_start(:wednesday).should == 3
        date_or_time(2011,11,06,0,0,0).days_to_week_start(:thursday).should == 3
        date_or_time(2011,11,07,0,0,0).days_to_week_start(:friday).should == 3
        date_or_time(2011,11,8,0,0,0).days_to_week_start(:saturday).should == 3
        date_or_time(2011,11,9,0,0,0).days_to_week_start(:sunday).should == 3
      end
      
      it "should be calculated correctly with default beginning of week" do
        begin
          old_bw = Date.beginning_of_week
          Date.beginning_of_week = :friday
        
          date_or_time(2012,03,8,0,0,0).days_to_week_start.should == 6
          date_or_time(2012,03,7,0,0,0).days_to_week_start.should == 5
          date_or_time(2012,03,6,0,0,0).days_to_week_start.should == 4
          date_or_time(2012,03,5,0,0,0).days_to_week_start.should == 3
          date_or_time(2012,03,4,0,0,0).days_to_week_start.should == 2
          date_or_time(2012,03,3,0,0,0).days_to_week_start.should == 1
          date_or_time(2012,03,2,0,0,0).days_to_week_start.should == 0
        ensure
          Date.beginning_of_week = old_bw
        end
      end
    end
    
    describe "beginning_of_week" do
      it "should be calculated correctly" do
        date_or_time(2005,2,4,10,10,10).beginning_of_week.should == date_or_time(2005,1,31,0,0,0)
        date_or_time(2005,11,28,0,0,0).beginning_of_week.should == date_or_time(2005,11,28,0,0,0)
        date_or_time(2005,11,29,0,0,0).beginning_of_week.should == date_or_time(2005,11,28,0,0,0)
        date_or_time(2005,11,30,0,0,0).beginning_of_week.should == date_or_time(2005,11,28,0,0,0)
        date_or_time(2005,12,01,0,0,0).beginning_of_week.should == date_or_time(2005,11,28,0,0,0)
        date_or_time(2005,12,02,0,0,0).beginning_of_week.should == date_or_time(2005,11,28,0,0,0)
        date_or_time(2005,12,03,0,0,0).beginning_of_week.should == date_or_time(2005,11,28,0,0,0)
        date_or_time(2005,12,04,0,0,0).beginning_of_week.should == date_or_time(2005,11,28,0,0,0)
      end
    end
    
    describe "end_of_week" do
      it "should be calculated correctly" do
        date_or_time(2007,12,31,10,10,10).end_of_week.should == date_or_time(2008,1,6,23,59,59,Rational(999999999, 1000))
        date_or_time(2007,8,27,0,0,0).end_of_week.should == date_or_time(2007,9,2,23,59,59,Rational(999999999, 1000))
        date_or_time(2007,8,28,0,0,0).end_of_week.should == date_or_time(2007,9,2,23,59,59,Rational(999999999, 1000))
        date_or_time(2007,8,29,0,0,0).end_of_week.should == date_or_time(2007,9,2,23,59,59,Rational(999999999, 1000))
        date_or_time(2007,8,30,0,0,0).end_of_week.should == date_or_time(2007,9,2,23,59,59,Rational(999999999, 1000))
        date_or_time(2007,8,31,0,0,0).end_of_week.should == date_or_time(2007,9,2,23,59,59,Rational(999999999, 1000))
        date_or_time(2007,9,01,0,0,0).end_of_week.should == date_or_time(2007,9,2,23,59,59,Rational(999999999, 1000))
        date_or_time(2007,9,02,0,0,0).end_of_week.should == date_or_time(2007,9,2,23,59,59,Rational(999999999, 1000))
      end
    end
    
    describe "end_of_month" do
      it "should be calculated correctly" do
        date_or_time(2005,3,20,10,10,10).end_of_month.should == date_or_time(2005,3,31,23,59,59,Rational(999999999, 1000))
        date_or_time(2005,2,20,10,10,10).end_of_month.should == date_or_time(2005,2,28,23,59,59,Rational(999999999, 1000))
        date_or_time(2005,4,20,10,10,10).end_of_month.should == date_or_time(2005,4,30,23,59,59,Rational(999999999, 1000))
      end
    end
    
    describe "end_of_year" do
      it "should be calculated correctly" do
        date_or_time(2007,2,22,10,10,10).end_of_year.should == date_or_time(2007,12,31,23,59,59,Rational(999999999, 1000))
        date_or_time(2007,12,31,10,10,10).end_of_year.should == date_or_time(2007,12,31,23,59,59,Rational(999999999, 1000))
      end
    end
    
    describe "weekdays" do
      it "should return monday with default beginning of week" do
        begin
          old_bw = Date.beginning_of_week
          Date.beginning_of_week = :saturday
        
          date_or_time(2012,9,18,0,0,0).monday.should == date_or_time(2012,9,17,0,0,0)
        ensure
          Date.beginning_of_week = old_bw
        end
      end
      
      it "should return sunday with default beginning of week" do
        begin
          old_bw = Date.beginning_of_week
          Date.beginning_of_week = :wednesday
        
          date_or_time(2012,9,19,0,0,0).sunday.should == date_or_time(2012,9,23,23,59,59, Rational(999999999, 1000))
        ensure
          Date.beginning_of_week = old_bw
        end
      end
    end
  end
end
