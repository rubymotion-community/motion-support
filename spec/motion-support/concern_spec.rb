class ConcernTest
  module Baz
    extend MotionSupport::Concern

    module ClassMethods
      def baz
        "baz"
      end

      def included_ran=(value)
        @@included_ran = value
      end

      def included_ran
        @@included_ran
      end
    end

    included do
      self.included_ran = true
    end

    def baz
      "baz"
    end
  end

  module Bar
    extend MotionSupport::Concern

    include Baz

    def bar
      "bar"
    end

    def baz
      "bar+" + super
    end
  end

  module Foo
    extend MotionSupport::Concern

    include Bar, Baz
  end
end

describe "Concern" do
  before do
    @klass = Class.new
  end

  it "should be included normally" do
    @klass.send(:include, ConcernTest::Baz)
    @klass.new.baz.should == "baz"
    @klass.included_modules.include?(ConcernTest::Baz).should.be.true

    @klass.send(:include, ConcernTest::Baz)
    @klass.new.baz.should == "baz"
    @klass.included_modules.include?(ConcernTest::Baz).should.be.true
  end

  it "should extend class methods" do
    @klass.send(:include, ConcernTest::Baz)
    @klass.baz.should == "baz"
    (class << @klass; self.included_modules; end)[0].should == ConcernTest::Baz::ClassMethods
  end

  it "should include instance methods" do
    @klass.send(:include, ConcernTest::Baz)
    @klass.new.baz.should == "baz"
    @klass.included_modules.include?(ConcernTest::Baz).should.be.true
  end

  it "should run included block" do
    @klass.send(:include, ConcernTest::Baz)
    @klass.included_ran.should.be.true
  end

  it "should meet dependencies" do
    @klass.send(:include, ConcernTest::Bar)
    @klass.new.bar.should == "bar"
    @klass.new.baz.should == "bar+baz"
    @klass.baz.should == "baz"
    @klass.included_modules.include?(ConcernTest::Bar).should.be.true
  end

  it "should meet dependencies with multiple modules" do
    @klass.send(:include, ConcernTest::Foo)
    @klass.included_modules[0..2].should == [ConcernTest::Foo, ConcernTest::Bar, ConcernTest::Baz]
  end
end
