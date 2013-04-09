describe "module" do
  describe "attribute accessors" do
    before do
      @module = Module.new
      @module.instance_eval do
        mattr_accessor :foo
        mattr_accessor :bar
        mattr_reader   :shaq
        mattr_accessor :camp
      end
    end
    
    describe "reader" do
      it "should return nil by default" do
        @module.foo.should.be.nil
      end
    end
    
    describe "writer" do
      it "should set value" do
        @module.foo = :test
        @module.foo.should == :test
      end
    end
  end
  
  describe "invalid attribute accessors" do
    it "should raise NameError when creating an invalid reader" do
      lambda do
        Class.new do
          mattr_reader "invalid attribute name"
        end
      end.should.raise NameError
    end
    
    it "should raise NameError when creating an invalid writer" do
      lambda do
        Class.new do
          mattr_writer "invalid attribute name"
        end
      end.should.raise NameError
    end
  end
end
