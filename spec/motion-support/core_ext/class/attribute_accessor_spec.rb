class CAttrAccessorBase
  cattr_accessor :empty_accessor
  cattr_accessor :base_accessor, :derived_accessor
end

class CAttrAccessorDerived < CAttrAccessorBase
end

describe "class" do
  describe "attribute accessors" do
    before do
      @class = Class.new
      @class.instance_eval do
        cattr_accessor :foo
        cattr_accessor :bar, :instance_writer => false
        cattr_reader   :shaq, :instance_reader => false
        cattr_accessor :camp, :instance_accessor => false
        cattr_reader   :rdrb do 'block' end
        cattr_reader   :rdrd, :default => 'default'
      end
      @object = @class.new
    end

    describe "reader" do
      it "should return nil by default" do
        @class.foo.should.be.nil
      end

      it "should return nil by default for instance" do
        @object.foo.should.be.nil
      end

      it "should return block if one was present" do
        @class.rdrb.should == 'block'
      end

      it "should return block if one was present for instance" do
        @object.rdrb.should == 'block'
      end

      it "should return default if one was specified" do
        @class.rdrd.should == 'default'
      end

      it "should return default if one was given for instance" do
        @object.rdrd.should == 'default'
      end
    end

    describe "writer" do
      it "should set value" do
        @class.foo = :test
        @class.foo.should == :test
      end

      it "should set value through instance writer" do
        @object.foo = :bar
        @object.foo.should == :bar
      end

      it "should set instance reader's value through module's writer" do
        @class.foo = :test
        @object.foo.should == :test
      end

      it "should set module reader's value through instances's writer" do
        @object.foo = :bar
        @class.foo.should == :bar
      end
    end

    describe "instance_writer => false" do
      it "should not create instance writer" do
        @class.should.respond_to :foo
        @class.should.respond_to :foo=
        @object.should.respond_to :bar
        @object.should.not.respond_to :bar=
      end
    end

    describe "instance_reader => false" do
      it "should not create instance reader" do
        @class.should.respond_to :shaq
        @object.should.not.respond_to :shaq
      end
    end

    describe "instance_accessor => false" do
      it "should not create reader or writer" do
        @class.should.respond_to :camp
        @object.should.not.respond_to :camp
        @object.should.not.respond_to :camp=
      end
    end
  end

  describe "invalid attribute accessors" do
    it "should raise NameError when creating an invalid reader" do
      lambda do
        Class.new do
          cattr_reader "invalid attribute name"
        end
      end.should.raise NameError
    end

    it "should raise NameError when creating an invalid writer" do
      lambda do
        Class.new do
          cattr_writer "invalid attribute name"
        end
      end.should.raise NameError
    end
  end

  describe "inheritance" do
    it "should be accessible in the base class and the derived class" do
      CAttrAccessorBase.respond_to?(:empty_accessor).should == true
      CAttrAccessorDerived.respond_to?(:empty_accessor).should == true
    end

    it "should return nil for an unset accessor in the base class" do
      CAttrAccessorBase.empty_accessor.should == nil
    end

    it "should return nil for an unset accessor in the derived class" do
      CAttrAccessorDerived.empty_accessor.should == nil
    end

    it "should return a value for an accessor set in the base class in the base class" do
      CAttrAccessorBase.base_accessor = 10
      CAttrAccessorBase.base_accessor.should == 10
    end

    it "should return a value for an accessor set in the base class in the derived class" do
      CAttrAccessorBase.base_accessor = 10
      CAttrAccessorDerived.base_accessor.should == 10
    end

    it "should return a value for the base class if set for the derived class" do
      CAttrAccessorDerived.derived_accessor = 20
      CAttrAccessorBase.derived_accessor.should == 20
    end

    it "should return a value for an accessor set in the derived class in the derived class" do
      CAttrAccessorDerived.derived_accessor = 20
      CAttrAccessorDerived.derived_accessor.should == 20
    end
  end
end
