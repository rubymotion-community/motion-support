describe "Date" do
  describe "calculations" do
    describe "yesterday" do
      it "should calculate yesterday's date" do
        Date.new(1982,10,15).yesterday.should == Date.new(1982,10,14)
      end
      
      it "should construct yesterday's date" do
        Date.yesterday.should == Date.current - 1
      end
    end
    
    describe "tomorrow" do
      it "should calculate tomorrow's date" do
        Date.new(1982,10,4).tomorrow.should == Date.new(1982,10,5)
      end
      
      it "should construct tomorrow's date" do
        Date.tomorrow.should == Date.current + 1
      end
    end
    
    describe "change" do
      it "should change correctly" do
        Date.new(2005,2,11).change(:day => 21).should == Date.new(2005,2,21)
        Date.new(2005,2,11).change(:year => 2007, :month => 5).should == Date.new(2007,5,11)
        Date.new(2005,2,22).change(:year => 2006).should == Date.new(2006,2,22)
        Date.new(2005,2,22).change(:month => 6).should == Date.new(2005,6,22)
      end
    end
    
    describe "sunday" do
      it "should calculate correctly" do
        Date.new(2008,3,02).sunday.should == Date.new(2008,3,2)
        Date.new(2008,2,29).sunday.should == Date.new(2008,3,2)
      end
    end
    
    describe "beginning_of_week" do
      it "should calculate correctly" do
        Date.new(1982,10,15).beginning_of_week.should == Date.new(1982,10,11)
      end
    end
    
    describe "end_of_week" do
      it "should calculate correctly" do
        Date.new(1982,10,4).end_of_week.should == Date.new(1982,10,10)
      end
    end
    
    describe "end_of_year" do
      it "should calculate correctly" do
        Date.new(2008,2,22).end_of_year.should == Date.new(2008,12,31)
      end
    end
    
    describe "end_of_month" do
      it "should calculate correctly" do
        Date.new(2005,3,20).end_of_month.should == Date.new(2005,3,31)
        Date.new(2005,2,20).end_of_month.should == Date.new(2005,2,28)
        Date.new(2005,4,20).end_of_month.should == Date.new(2005,4,30)
      end
    end
    
    describe "prev_year" do
      it "should calculate correctly" do
        Date.new(1983,10,14).prev_year.should == Date.new(1982,10,14)
      end
      
      it "should work with leap years" do
        Date.new(2000,2,29).prev_year.should == Date.new(1999,2,28)
      end
    end
    
    describe "last_year" do
      it "should calculate correctly" do
        Date.new(2005,6,5).last_year.should == Date.new(2004,6,5)
        Date.new(1983,10,14).last_year.should == Date.new(1982,10,14)
      end
      
      it "should work with leap years" do
        Date.new(2000,2,29).last_year.should == Date.new(1999,2,28)
      end
    end
    
    describe "next_year" do
      it "should calculate correctly" do
        Date.new(1981,10,10).next_year.should == Date.new(1982,10,10)
      end
      
      it "should work with leap years" do
        Date.new(2000,2,29).next_year.should == Date.new(2001,2,28)
      end
    end
    
    describe "advance" do
      it "should calculate correctly" do
        Date.new(2005,2,28).advance(:years => 1).should == Date.new(2006,2,28)
        Date.new(2005,2,28).advance(:months => 4).should == Date.new(2005,6,28)
        Date.new(2005,2,28).advance(:weeks => 3).should == Date.new(2005,3,21)
        Date.new(2005,2,28).advance(:days => 5).should == Date.new(2005,3,5)
        Date.new(2005,2,28).advance(:years => 7, :months => 7).should == Date.new(2012,9,28)
        Date.new(2005,2,28).advance(:years => 7, :months => 19, :days => 5).should == Date.new(2013,10,3)
        Date.new(2005,2,28).advance(:years => 7, :months => 19, :weeks => 2, :days => 5).should == Date.new(2013,10,17)
        Date.new(2004,2,29).advance(:years => 1).should == Date.new(2005,2,28)
      end
      
      it "should advance years before days" do
        Date.new(2011, 2, 28).advance(:years => 1, :days => 1).should == Date.new(2012, 2, 29)
      end
      
      it "should advance months before days" do
        Date.new(2010, 2, 28).advance(:months => 1, :days => 1).should == Date.new(2010, 3, 29)
      end
      
      it "should not change passed option hash" do
        options = { :years => 3, :months => 11, :days => 2 }
        Date.new(2005,2,28).advance(options)
        options.should == { :years => 3, :months => 11, :days => 2 }
      end
    end
    
    describe "last_week" do
      it "should calculate correctly" do
        Date.new(2005,5,17).last_week.should == Date.new(2005,5,9)
        Date.new(2007,1,7).last_week.should == Date.new(2006,12,25)
        Date.new(2010,2,19).last_week(:friday).should == Date.new(2010,2,12)
        Date.new(2010,2,19).last_week(:saturday).should == Date.new(2010,2,13)
        Date.new(2010,3,4).last_week(:saturday).should == Date.new(2010,2,27)
      end
    end
    
    describe "last_month" do
      it "should calculate correctly on the 31st" do
        Date.new(2004, 3, 31).last_month.should == Date.new(2004, 2, 29)
        
      end
    end
    
    describe "last_quarter" do
      it "should calculate correctly on the 31st" do
        Date.new(2004, 5, 31).last_quarter.should == Date.new(2004, 2, 29)
      end
    end
    
    describe "since" do
      it "should calculate correctly" do
        Date.new(2005,2,21).since(45).should == Time.local(2005,2,21,0,0,45)
      end
    end
    
    describe "ago" do
      it "should calculate correctly" do
        Date.new(2005,2,21).ago(45).should == Time.local(2005,2,20,23,59,15)
      end
    end
    
    describe "beginning_of_day" do
      it "should calculate correctly" do
        Date.new(2005,2,21).beginning_of_day.should == Time.local(2005,2,21,0,0,0)
      end
    end
    
    describe "end_of_day" do
      it "should calculate correctly" do
        Date.new(2005,2,21).end_of_day.should == Time.local(2005,2,21,23,59,59,Rational(999999999, 1000))
      end
    end
    
    describe "past?" do
      it "should calculate correctly" do
        Date.yesterday.should.be.past
        Date.today.last_week.should.be.past
        Date.tomorrow.should.not.be.past
      end
    end
    
    describe "future?" do
      it "should calculate correctly" do
        Date.tomorrow.should.be.future
        Date.today.next_week.should.be.future
        Date.yesterday.should.not.be.future
      end
    end
  end
end
