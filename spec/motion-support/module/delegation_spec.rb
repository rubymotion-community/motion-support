module ModuleDelegation
  class Delegator
    def receive
      "result"
    end
  end
  
  class InstanceVariable
    def initialize
      @instance_variable = Delegator.new
    end
    delegate :receive, :to => '@instance_variable'
  end
  
  class ClassVariable
    def initialize
      @@class_variable = Delegator.new
    end
    delegate :receive, :to => '@@class_variable'
  end
  
  class RelativeConstant
    Receiver = Delegator.new
    delegate :receive, :to => 'Receiver'
  end
  
  class AbsoluteConstant
    Receiver = Delegator.new
    delegate :receive, :to => 'ModuleDelegation::AbsoluteConstant::Receiver'
  end
  
  class Method
    def method
      Delegator.new
    end
    delegate :receive, :to => :method
  end
  
  class MethodChain
    def first
      self
    end
    
    def second
      Delegator.new
    end
    delegate :receive, :to => 'first.second'
  end
  
  class ConstantSingleton
    class Nested
      def self.method
        Delegator.new
      end
    end
    delegate :receive, :to => 'Nested.method'
  end
  
  class AllowNil
    delegate :receive, :to => '@undefined', :allow_nil => true
  end
  
  class DisallowNil
    delegate :receive, :to => '@undefined'
  end
  
  class NonexistentMethod
    delegate :receive, :to => :nonexistent_method
  end
  
  class Prefix
    def method
      Delegator.new
    end
    delegate :receive, :to => :method, :prefix => 'foo'
  end
  
  class AutoPrefix
    def method
      Delegator.new
    end
    delegate :receive, :to => :method, :prefix => true
  end
end

describe "module" do
  describe "delegation" do
    it "should delegate to instance variable" do
      ModuleDelegation::InstanceVariable.new.receive.should == "result"
    end
    
    it "should delegate to class variable" do
      ModuleDelegation::ClassVariable.new.receive.should == "result"
    end
    
    it "should delegate to relative constant" do
      ModuleDelegation::RelativeConstant.new.receive.should == "result"
    end
    
    it "should delegate to absolute constant" do
      ModuleDelegation::AbsoluteConstant.new.receive.should == "result"
    end
    
    it "should delegate to method" do
      ModuleDelegation::Method.new.receive.should == "result"
    end
    
    it "should delegate to method chain" do
      ModuleDelegation::MethodChain.new.receive.should == "result"
    end
    
    it "should delegate to constant's singleton method" do
      ModuleDelegation::ConstantSingleton.new.receive.should == "result"
    end
    
    it "should delegate to nil without raising an error when allowed" do
      ModuleDelegation::AllowNil.new.receive.should.be.nil
    end
    
    it "should raise an error when delegating to nil and not allowed" do
      lambda { ModuleDelegation::DisallowNil.new.receive }.should.raise
    end
    
    it "should raise an error when delegating to non-existent method" do
      lambda { ModuleDelegation::NonexistentMethod.new.receive }.should.raise NoMethodError
    end
    
    it "should delegate with prefix" do
      ModuleDelegation::Prefix.new.foo_receive.should == "result"
    end
    
    it "should delegate to method with automatic prefix" do
      ModuleDelegation::AutoPrefix.new.method_receive.should == "result"
    end
  end
end
