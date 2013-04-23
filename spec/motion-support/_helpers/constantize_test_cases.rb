module Ace
  module Base
    class Case
      class Dice
      end
    end
    class Fase < Case
    end
  end
  class Gas
    include Base
  end
end

class Object
  module AddtlGlobalConstants
    class Case
      class Dice
      end
    end
  end
  include AddtlGlobalConstants
end

module ConstantizeTestCases
  def run_constantize_tests_on(&block)
    yield("Ace::Base::Case").should == Ace::Base::Case
    yield("::Ace::Base::Case").should == Ace::Base::Case
    yield("Ace::Base::Case::Dice").should == Ace::Base::Case::Dice
    yield("Ace::Base::Fase::Dice").should == Ace::Base::Fase::Dice
    yield("Ace::Gas::Case").should == Ace::Gas::Case
    yield("Ace::Gas::Case::Dice").should == Ace::Gas::Case::Dice
    yield("Case::Dice").should == Case::Dice
    yield("Object::Case::Dice").should == Case::Dice
    yield("ConstantizeTestCases").should == ConstantizeTestCases
    yield("::ConstantizeTestCases").should == ConstantizeTestCases
    yield("").should == Object
    yield("::").should == Object
    lambda { block.call("UnknownClass") }.should.raise NameError
    lambda { block.call("UnknownClass::Ace") }.should.raise NameError
    lambda { block.call("UnknownClass::Ace::Base") }.should.raise NameError
    lambda { block.call("An invalid string") }.should.raise NameError
    lambda { block.call("InvalidClass\n") }.should.raise NameError
    lambda { block.call("Ace::ConstantizeTestCases") }.should.raise NameError
    lambda { block.call("Ace::Base::ConstantizeTestCases") }.should.raise NameError
    lambda { block.call("Ace::Gas::Base") }.should.raise NameError
    lambda { block.call("Ace::Gas::ConstantizeTestCases") }.should.raise NameError
  end

  def run_safe_constantize_tests_on
    yield("Ace::Base::Case").should == Ace::Base::Case
    yield("::Ace::Base::Case").should == Ace::Base::Case
    yield("Ace::Base::Case::Dice").should == Ace::Base::Case::Dice
    yield("Ace::Base::Fase::Dice").should == Ace::Base::Fase::Dice
    yield("Ace::Gas::Case").should == Ace::Gas::Case
    yield("Ace::Gas::Case::Dice").should == Ace::Gas::Case::Dice
    yield("Case::Dice").should == Case::Dice
    yield("Object::Case::Dice").should == Case::Dice
    yield("ConstantizeTestCases").should == ConstantizeTestCases
    yield("::ConstantizeTestCases").should == ConstantizeTestCases
    yield("").should == Object
    yield("::").should == Object
    yield("UnknownClass").should.be.nil
    yield("UnknownClass::Ace").should.be.nil
    yield("UnknownClass::Ace::Base").should.be.nil
    yield("An invalid string").should.be.nil
    yield("InvalidClass\n").should.be.nil
    yield("blargle").should.be.nil
    yield("Ace::ConstantizeTestCases").should.be.nil
    yield("Ace::Base::ConstantizeTestCases").should.be.nil
    yield("Ace::Gas::Base").should.be.nil
    yield("Ace::Gas::ConstantizeTestCases").should.be.nil
    yield("#<Class:0x7b8b718b>::Nested_1").should.be.nil
  end
end
