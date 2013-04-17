describe "class" do
  describe "class_attribute" do
    before do
      @klass = Class.new
      @klass.class_eval { class_attribute :setting }
      @sub = Class.new(@klass)
    end

    it "should default to nil" do
      @klass.setting.should.be.nil
      @sub.setting.should.be.nil
    end

    it "should be inheritable" do
      @klass.setting = 1
      @sub.setting.should == 1
    end
    
    it "should be overridable" do
      @sub.setting = 1
      @klass.setting.should.be.nil
      
      @klass.setting = 2
      @sub.setting.should == 1
      
      Class.new(@sub).setting.should == 1
    end
    
    it "should define a query method" do
      @klass.setting?.should.be.false
      @klass.setting = 1
      @klass.setting?.should.be.true
    end
    
    it "should define an instance reader that delegates to class" do
      @klass.new.setting.should.be.nil
    
      @klass.setting = 1
      @klass.new.setting.should == 1
    end
    
    it "should allow to override per instance" do
      object = @klass.new
      object.setting = 1
      @klass.setting.should == nil
      @klass.setting = 2
      object.setting.should == 1
    end
    
    it "should define query method on instance" do
      object = @klass.new
      object.setting?.should.be.false
      object.setting = 1
      object.setting?.should.be.true
    end
    
    describe "instance_writer => false" do
      it "should not create instance writer" do
        object = Class.new { class_attribute :setting, :instance_writer => false }.new
        lambda { object.setting = 'boom' }.should.raise NoMethodError
      end
    end
    
    describe "instance_reader => false" do
      it "should not create instance reader" do
        object = Class.new { class_attribute :setting, :instance_reader => false }.new
        lambda { object.setting }.should.raise NoMethodError
        lambda { object.setting? }.should.raise NoMethodError
      end
    end
    
    describe "instance_accessor => false" do
      it "should not create reader or writer" do
        object = Class.new { class_attribute :setting, :instance_accessor => false }.new
        lambda { object.setting }.should.raise NoMethodError
        lambda { object.setting? }.should.raise NoMethodError
        lambda { object.setting = 'boom' }.should.raise NoMethodError
      end
    end
    
    it "should work well with singleton classes" do
      object = @klass.new
      object.singleton_class.setting = 'foo'
      object.setting.should == "foo"
    end
    
    it "should return set value through setter" do
      val = @klass.send(:setting=, 1)
      val.should == 1
    end
  end
end
