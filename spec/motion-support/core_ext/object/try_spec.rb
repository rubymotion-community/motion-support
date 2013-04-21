describe "Object" do
  before do
    @string = "Hello"
  end

  describe "try" do
    it "should return nil for nonexisting method" do
      method = :undefined_method
      @string.should.not.respond_to method
      @string.try(method).should.be.nil
    end

    it "should return nil for nonexisting method with arguments" do
      method = :undefined_method
      @string.should.not.respond_to method
      @string.try(method, 'llo', 'y').should.be.nil
    end

    it "should delegate to existing method" do
      @string.try(:size).should == 5
    end

    it "should forward arguments to existing method" do
      @string.try(:sub, 'llo', 'y').should == 'Hey'
    end

    it "should forward block to existing method" do
      @string.try(:sub, 'llo') { |match| 'y' }.should == 'Hey'
    end

    it "should return nil when called on nil even if method is defined on nil" do
      nil.try(:to_s).should.be.nil
      nil.try(:to_i).should.be.nil
    end

    it "should work as expected on false" do
      false.try(:to_s).should == 'false'
    end

    it "should pass existing receiver to block" do
      @string.try { |s| s.reverse }.should == @string.reverse
    end

    it "should not pass nil to block" do
      ran = false
      nil.try { ran = true }
      ran.should == false
    end

    it "should not call private method" do
      klass = Class.new do
        private

        def private_method
          'private method'
        end
      end

      klass.new.try(:private_method).should == nil
    end
  end

  describe "try!" do
    it "should raise error for nonexisting method" do
      method = :undefined_method
      @string.should.not.respond_to method
      lambda { @string.try!(method) }.should.raise NoMethodError
    end

    it "should raise error for nonexisting method with arguments" do
      method = :undefined_method
      @string.should.not.respond_to method
      lambda { @string.try!(method, 'llo', 'y') }.should.raise NoMethodError
    end

    it "should pass existing receiver to block" do
      @string.try! { |s| s.reverse }.should == @string.reverse
    end

    it "should raise error when calling private method" do
      klass = Class.new do
        private

        def private_method
          'private method'
        end
      end

      lambda { klass.new.try!(:private_method) }.should.raise NoMethodError
    end
  end
end
