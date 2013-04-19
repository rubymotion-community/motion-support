describe "module" do
  describe "attr_internal" do
    before do
      @target = Class.new
      @instance = @target.new
    end
    
    describe "reader" do
      it "should define reader" do
        lambda { @target.attr_internal_reader :foo }.should.not.raise
      end

      describe "defined" do
        before do
          @target.attr_internal_reader :foo
        end
  
        it "should not have instance variable at first" do
          @instance.instance_variable_defined?('@_foo').should.not.be.true
        end
  
        it "should not define writer" do
          lambda { @instance.foo = 1 }.should.raise NoMethodError
        end
  
        it "should return value of internal reader" do
          @instance.instance_variable_set('@_foo', 1)
          lambda { @instance.foo.should == 1 }.should.not.raise
        end
      end
    end
    
    describe "writer" do
      it "should define writer" do
        lambda { @target.attr_internal_writer :foo }.should.not.raise
      end

      describe "defined" do
        before do
          @target.attr_internal_writer :foo
        end
  
        it "should not have instance variable at first" do
          @instance.instance_variable_defined?('@_foo').should.not.be.true
        end
  
        it "should set instance variable" do
          lambda { @instance.foo = 1 }.should.not.raise
          @instance.instance_variable_defined?('@_foo').should.be.true
          @instance.instance_variable_get('@_foo').should == 1
        end
  
        it "should not define reader" do
          lambda { @instance.foo }.should.raise NoMethodError
        end
      end
    end
    
    describe "accessor" do
      it "should define accessor" do
        lambda { @target.attr_internal :foo }.should.not.raise
      end

      describe "defined" do
        before do
          @target.attr_internal :foo
        end
  
        it "should not have instance variable at first" do
          @instance.instance_variable_defined?('@_foo').should.not.be.true
        end
  
        it "should set instance variable" do
          lambda { @instance.foo = 1 }.should.not.raise
          @instance.instance_variable_defined?('@_foo').should.be.true
          @instance.instance_variable_get('@_foo').should == 1
        end
  
        it "should read from instance variable" do
          @instance.instance_variable_set('@_foo', 1)
          lambda { @instance.foo }.should.not.raise
        end
      end
    end
    
    describe "naming format" do
      it "should allow custom naming format for instance variable" do
        begin
          Module.attr_internal_naming_format.should == '@_%s'
          lambda { Module.attr_internal_naming_format = '@abc%sdef' }.should.not.raise
          @target.attr_internal :foo

          @instance.instance_variable_defined?('@_foo').should.be.false
          @instance.instance_variable_defined?('@abcfoodef').should.be.false
          lambda { @instance.foo = 1 }.should.not.raise
          @instance.instance_variable_defined?('@_foo').should.not.be.true
          @instance.instance_variable_defined?('@abcfoodef').should.be.true
        ensure
          Module.attr_internal_naming_format = '@_%s'
        end
      end
    end
  end
end
