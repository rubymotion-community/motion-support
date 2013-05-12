module CallbacksTest
  class Record
    include MotionSupport::Callbacks

    define_callbacks :save

    def self.before_save(*filters, &blk)
      set_callback(:save, :before, *filters, &blk)
    end

    def self.after_save(*filters, &blk)
      set_callback(:save, :after, *filters, &blk)
    end

    class << self
      def callback_symbol(callback_method)
        method_name = :"#{callback_method}_method"
        define_method(method_name) do
          history << [callback_method, :symbol]
        end
        method_name
      end

      def callback_proc(callback_method)
        Proc.new { |model| model.history << [callback_method, :proc] }
      end

      def callback_object(callback_method)
        klass = Class.new
        klass.send(:define_method, callback_method) do |model|
          model.history << [:"#{callback_method}_save", :object]
        end
        klass.new
      end
    end

    def history
      @history ||= []
    end
  end

  class Person < Record
    [:before_save, :after_save].each do |callback_method|
      callback_method_sym = callback_method.to_sym
      send(callback_method, callback_symbol(callback_method_sym))
      send(callback_method, callback_proc(callback_method_sym))
      send(callback_method, callback_object(callback_method_sym.to_s.gsub(/_save/, '')))
      send(callback_method) { |model| model.history << [callback_method_sym, :block] }
    end

    def save
      run_callbacks :save
    end
  end

  class PersonSkipper < Person
    skip_callback :save, :before, :before_save_method, :if => :yes
    skip_callback :save, :after, :before_save_method, :unless => :yes
    skip_callback :save, :after, :before_save_method, :if => :no
    skip_callback :save, :before, :before_save_method, :unless => :no
    def yes; true; end
    def no; false; end
  end

  class ParentController
    include MotionSupport::Callbacks

    define_callbacks :dispatch

    set_callback :dispatch, :before, :log, :unless => proc {|c| c.action_name == :index || c.action_name == :show }
    set_callback :dispatch, :after, :log2

    attr_reader :action_name, :logger
    def initialize(action_name)
      @action_name, @logger = action_name, []
    end

    def log
      @logger << action_name
    end

    def log2
      @logger << action_name
    end

    def dispatch
      run_callbacks :dispatch do
        @logger << "Done"
      end
      self
    end
  end

  class Child < ParentController
    skip_callback :dispatch, :before, :log, :if => proc {|c| c.action_name == :update}
    skip_callback :dispatch, :after, :log2
  end

  class OneTimeCompile < Record
    @@starts_true, @@starts_false = true, false

    def initialize
      super
    end

    before_save Proc.new {|r| r.history << [:before_save, :starts_true, :if] }, :if => :starts_true
    before_save Proc.new {|r| r.history << [:before_save, :starts_false, :if] }, :if => :starts_false
    before_save Proc.new {|r| r.history << [:before_save, :starts_true, :unless] }, :unless => :starts_true
    before_save Proc.new {|r| r.history << [:before_save, :starts_false, :unless] }, :unless => :starts_false

    def starts_true
      if @@starts_true
        @@starts_true = false
        return true
      end
      @@starts_true
    end

    def starts_false
      unless @@starts_false
        @@starts_false = true
        return false
      end
      @@starts_false
    end

    def save
      run_callbacks :save
    end
  end

  class AfterSaveConditionalPerson < Record
    after_save Proc.new { |r| r.history << [:after_save, :string1] }
    after_save Proc.new { |r| r.history << [:after_save, :string2] }
    def save
      run_callbacks :save
    end
  end

  class ConditionalPerson < Record
    # proc
    before_save Proc.new { |r| r.history << [:before_save, :proc] }, :if => Proc.new { |r| true }
    before_save Proc.new { |r| r.history << "b00m" }, :if => Proc.new { |r| false }
    before_save Proc.new { |r| r.history << [:before_save, :proc] }, :unless => Proc.new { |r| false }
    before_save Proc.new { |r| r.history << "b00m" }, :unless => Proc.new { |r| true }
    # symbol
    before_save Proc.new { |r| r.history << [:before_save, :symbol] }, :if => :yes
    before_save Proc.new { |r| r.history << "b00m" }, :if => :no
    before_save Proc.new { |r| r.history << [:before_save, :symbol] }, :unless => :no
    before_save Proc.new { |r| r.history << "b00m" }, :unless => :yes
    # string
    before_save Proc.new { |r| r.history << [:before_save, :string] }, :if => 'yes'
    before_save Proc.new { |r| r.history << "b00m" }, :if => 'no'
    before_save Proc.new { |r| r.history << [:before_save, :string] }, :unless => 'no'
    before_save Proc.new { |r| r.history << "b00m" }, :unless => 'yes'
    # Combined if and unless
    before_save Proc.new { |r| r.history << [:before_save, :combined_symbol] }, :if => :yes, :unless => :no
    before_save Proc.new { |r| r.history << "b00m" }, :if => :yes, :unless => :yes

    def yes; true; end
    def other_yes; true; end
    def no; false; end
    def other_no; false; end

    def save
      run_callbacks :save
    end
  end

  class CleanPerson < ConditionalPerson
    reset_callbacks :save
  end

  class MySuper
    include MotionSupport::Callbacks
    define_callbacks :save
  end

  class AroundPerson < MySuper
    attr_reader :history

    set_callback :save, :before, :nope,           :if =>     :no
    set_callback :save, :before, :nope,           :unless => :yes
    set_callback :save, :after,  :tweedle
    set_callback :save, :before, "tweedle_dee"
    set_callback :save, :before, proc {|m| m.history << "yup" }
    set_callback :save, :before, :nope,           :if =>     proc { false }
    set_callback :save, :before, :nope,           :unless => proc { true }
    set_callback :save, :before, :yup,            :if =>     proc { true }
    set_callback :save, :before, :yup,            :unless => proc { false }
    set_callback :save, :around, :tweedle_dum
    set_callback :save, :around, :w0tyes,         :if =>     :yes
    set_callback :save, :around, :w0tno,          :if =>     :no
    set_callback :save, :around, :tweedle_deedle

    def no; false; end
    def yes; true; end

    def nope
      @history << "boom"
    end

    def yup
      @history << "yup"
    end

    def w0tyes
      @history << "w0tyes before"
      yield
      @history << "w0tyes after"
    end

    def w0tno
      @history << "boom"
      yield
    end

    def tweedle_dee
      @history << "tweedle dee"
    end

    def tweedle_dum
      @history << "tweedle dum pre"
      yield
      @history << "tweedle dum post"
    end

    def tweedle
      @history << "tweedle"
    end

    def tweedle_deedle
      @history << "tweedle deedle pre"
      yield
      @history << "tweedle deedle post"
    end

    def initialize
      @history = []
    end

    def save
      run_callbacks :save do
        @history << "running"
      end
    end
  end

  class AroundPersonResult < MySuper
    attr_reader :result

    set_callback :save, :after, :tweedle_1
    set_callback :save, :around, :tweedle_dum
    set_callback :save, :after, :tweedle_2

    def tweedle_dum
      @result = yield
    end

    def tweedle_1
      :tweedle_1
    end

    def tweedle_2
      :tweedle_2
    end

    def save
      run_callbacks :save do
        :running
      end
    end
  end

  class HyphenatedCallbacks
    include MotionSupport::Callbacks
    define_callbacks :save
    attr_reader :stuff

    set_callback :save, :before, :action, :if => :yes

    def yes() true end

    def action
      @stuff = "ACTION"
    end

    def save
      run_callbacks :save do
        @stuff
      end
    end
  end

  module ExtendModule
    def self.extended(base)
      base.class_eval do
        set_callback :save, :before, :record3
      end
    end
    def record3
      @recorder << 3
    end
  end

  module IncludeModule
    def self.included(base)
      base.class_eval do
        set_callback :save, :before, :record2
      end
    end
    def record2
      @recorder << 2
    end
  end

  class ExtendCallbacks

    include MotionSupport::Callbacks

    define_callbacks :save
    set_callback :save, :before, :record1

    include IncludeModule

    def save
      run_callbacks :save
    end

    attr_reader :recorder

    def initialize
      @recorder = []
    end

    private

      def record1
        @recorder << 1
      end
  end

  class CallbackTerminator
    include MotionSupport::Callbacks

    define_callbacks :save, :terminator => lambda { |result| result == :halt }

    set_callback :save, :before, :first
    set_callback :save, :before, :second
    set_callback :save, :around, :around_it
    set_callback :save, :before, :third
    set_callback :save, :after, :first
    set_callback :save, :around, :around_it
    set_callback :save, :after, :second
    set_callback :save, :around, :around_it
    set_callback :save, :after, :third


    attr_reader :history, :saved, :halted
    def initialize
      @history = []
    end

    def around_it
      @history << "around1"
      yield
      @history << "around2"
    end

    def first
      @history << "first"
    end

    def second
      @history << "second"
      :halt
    end

    def third
      @history << "third"
    end

    def save
      run_callbacks :save do
        @saved = true
      end
    end

    def halted_callback_hook(filter)
      @halted = filter
    end
  end

  class CallbackObject
    def before(caller)
      caller.record << "before"
    end

    def before_save(caller)
      caller.record << "before save"
    end

    def around(caller)
      caller.record << "around before"
      yield
      caller.record << "around after"
    end
  end

  class UsingObjectBefore
    include MotionSupport::Callbacks

    define_callbacks :save
    set_callback :save, :before, CallbackObject.new

    attr_accessor :record
    def initialize
      @record = []
    end

    def save
      run_callbacks :save do
        @record << "yielded"
      end
    end
  end

  class UsingObjectAround
    include MotionSupport::Callbacks

    define_callbacks :save
    set_callback :save, :around, CallbackObject.new

    attr_accessor :record
    def initialize
      @record = []
    end

    def save
      run_callbacks :save do
        @record << "yielded"
      end
    end
  end

  class CustomScopeObject
    include MotionSupport::Callbacks

    define_callbacks :save, :scope => [:kind, :name]
    set_callback :save, :before, CallbackObject.new

    attr_accessor :record
    def initialize
      @record = []
    end

    def save
      run_callbacks :save do
        @record << "yielded"
        "CallbackResult"
      end
    end
  end

  class OneTwoThreeSave
    include MotionSupport::Callbacks

    define_callbacks :save

    attr_accessor :record

    def initialize
      @record = []
    end

    def save
      run_callbacks :save do
        @record << "yielded"
      end
    end

    def first
      @record << "one"
    end

    def second
      @record << "two"
    end

    def third
      @record << "three"
    end
  end

  class DuplicatingCallbacks < OneTwoThreeSave
    set_callback :save, :before, :first, :second
    set_callback :save, :before, :first, :third
  end

  class DuplicatingCallbacksInSameCall < OneTwoThreeSave
    set_callback :save, :before, :first, :second, :first, :third
  end

  class WriterSkipper < Person
    attr_accessor :age
    skip_callback :save, :before, :before_save_method, :if => lambda { |obj| obj.age > 21 }
  end
end

describe "Callbacks" do
  describe "around filter" do
    it "should optimize on first compile" do
      around = CallbacksTest::OneTimeCompile.new
      around.save
      around.history.should == [
        [:before_save, :starts_true, :if],
        [:before_save, :starts_true, :unless]
      ]
    end
    
    it "should call nested around filter" do
      around = CallbacksTest::AroundPerson.new
      around.save
      around.history.should == [
        "tweedle dee",
        "yup", "yup",
        "tweedle dum pre",
        "w0tyes before",
        "tweedle deedle pre",
        "running",
        "tweedle deedle post",
        "w0tyes after",
        "tweedle dum post",
        "tweedle"
      ]
    end
    
    it "should return result" do
      around = CallbacksTest::AroundPersonResult.new
      around.save
      around.result.should == :running
    end
  end
  
  describe "after save" do
    it "should run in reverse order" do
      person = CallbacksTest::AfterSaveConditionalPerson.new
      person.save
      person.history.should == [
        [:after_save, :string2],
        [:after_save, :string1]
      ]
    end
  end
  
  describe "skip callbacks" do
    it "should skip callback" do
      person = CallbacksTest::PersonSkipper.new
      person.history.should == []
      person.save
      person.history.should == [
        [:before_save, :proc],
        [:before_save, :object],
        [:before_save, :block],
        [:after_save, :block],
        [:after_save, :object],
        [:after_save, :proc],
        [:after_save, :symbol]
      ]
    end
    
    it "should not skip if condition is not met" do
      writer = CallbacksTest::WriterSkipper.new
      writer.age = 18
      writer.history.should == []
      writer.save
      writer.history.should == [
        [:before_save, :symbol],
        [:before_save, :proc],
        [:before_save, :object],
        [:before_save, :block],
        [:after_save, :block],
        [:after_save, :object],
        [:after_save, :proc],
        [:after_save, :symbol]
      ]
    end
  end
  
  it "should run callbacks" do
    person = CallbacksTest::Person.new
    person.history.should == []
    person.save
    person.history.should == [
      [:before_save, :symbol],
      [:before_save, :proc],
      [:before_save, :object],
      [:before_save, :block],
      [:after_save, :block],
      [:after_save, :object],
      [:after_save, :proc],
      [:after_save, :symbol]
    ]
  end
  
  it "should run conditional callbacks" do
    person = CallbacksTest::ConditionalPerson.new
    person.save
    person.history.should == [
      [:before_save, :proc],
      [:before_save, :proc],
      [:before_save, :symbol],
      [:before_save, :symbol],
      [:before_save, :string],
      [:before_save, :string],
      [:before_save, :combined_symbol],
    ]
  end
  
  it "should return result" do
    obj = CallbacksTest::HyphenatedCallbacks.new
    obj.save
    obj.stuff.should == "ACTION"
  end
  
  describe "reset_callbacks" do
    it "should reset callbacks" do
      person = CallbacksTest::CleanPerson.new
      person.save
      person.history.should == []
    end
  end
  
  describe "callback object" do
    it "should use callback object for before callback" do
      u = CallbacksTest::UsingObjectBefore.new
      u.save
      u.record.should == ["before", "yielded"]
    end

    it "should use callback object for around callback" do
      u = CallbacksTest::UsingObjectAround.new
      u.save
      u.record.should == ["around before", "yielded", "around after"]
    end

    describe "custom scope" do
      it "should use custom scope" do
        u = CallbacksTest::CustomScopeObject.new
        u.save
        u.record.should == ["before save", "yielded"]
      end

      it "should return block result" do
        u = CallbacksTest::CustomScopeObject.new
        u.save.should == "CallbackResult"
      end
    end
  end
  
  describe "callback terminator" do
    it "should terminate" do
      terminator = CallbacksTest::CallbackTerminator.new
      terminator.save
      terminator.history.should == ["first", "second", "third", "second", "first"]
    end

    it "should invoke hook" do
      terminator = CallbacksTest::CallbackTerminator.new
      terminator.save
      terminator.halted.should == ":second"
    end

    it "should never call block if terminated" do
      obj = CallbacksTest::CallbackTerminator.new
      obj.save
      obj.saved.should.be.nil
    end
  end
  
  describe "extending object" do
    it "should work with extending object" do
      model = CallbacksTest::ExtendCallbacks.new.extend CallbacksTest::ExtendModule
      model.save
      model.recorder.should == [1, 2, 3]
    end
  end
  
  describe "exclude duplicates" do
    it "should exclude duplicates in separate calls" do
      model = CallbacksTest::DuplicatingCallbacks.new
      model.save
      model.record.should == ["two", "one", "three", "yielded"]
    end

    it "should exclude duplicates in one call" do
      model = CallbacksTest::DuplicatingCallbacksInSameCall.new
      model.save
      model.record.should == ["two", "one", "three", "yielded"]
    end
  end
end
