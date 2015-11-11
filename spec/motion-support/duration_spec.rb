describe "Duration" do
  describe "threequals" do
    it "should be a day" do
      MotionSupport::Duration.should === 1.day
    end

    it "should not be an int" do
      MotionSupport::Duration.should.not === 1.day.to_i
    end

    it "should not be a string" do
      MotionSupport::Duration.should.not === 'foo'
    end
  end

  describe "equals" do
    it "should equal itself" do
      1.day.should == 1.day
    end

    it "should equal integer representation" do
      1.day.should == 1.day.to_i
    end

    it "should not equal string" do
      1.day.should.not == 'foo'
    end
  end

  describe "inspect" do
    it "should convert to string representation" do
      0.seconds.inspect.should == '0 seconds'
      1.month.inspect.should == '1 month'
      (1.month + 1.day).inspect.should == '1 month and 1 day'
      (6.months - 2.days).inspect.should == '6 months and -2 days'
      10.seconds.inspect.should == '10 seconds'
      (10.years + 2.months + 1.day).inspect.should == '10 years, 2 months, and 1 day'
      1.week.inspect.should == '7 days'
      1.fortnight.inspect.should == '14 days'
    end
  end

  describe "arithmetic" do
    it "should not break when subtracting time from itself" do
      lambda { Date.today - Date.today }.should.not.raise
    end

    it "should add with time" do
      (1.second + 1).should == 1 + 1.second
    end

    def test_plus_with_time
      assert_equal 1 + 1.second, 1.second + 1, "Duration + Numeric should == Numeric + Duration"
    end

  end

  describe "fractions" do
    describe "days" do
      it "should support fractional days" do
        1.5.weeks.should == (86400 * 7) * 1.5
        1.7.weeks.should == (86400 * 7) * 1.7
      end

      it "should support since" do
        t = 2.years.ago
        1.5.days.since(t).should == 36.hours.since(t)
      end

      it "should support ago" do
        t = 2.years.ago
        1.5.days.ago(t).should == 36.hours.ago(t)
      end
    end

    describe "weeks" do
      it "should support fractional weeks" do
        1.5.days.should == 86400 * 1.5
        1.7.days.should == 86400 * 1.7
      end

      it "should support since" do
        t = 2.years.ago
        1.5.weeks.since(t).should == (7 * 36).hours.since(t)
      end

      it "should support ago" do
        t = 2.years.ago
        1.5.weeks.ago(t).should == (7 * 36).hours.ago(t)
      end
    end
  end

  describe "delegation" do
    it "should delegate with block" do
      counter = 0
      lambda { 1.minute.times { counter += 1 } }.should.not.raise
      counter.should == 60
    end
  end
end
