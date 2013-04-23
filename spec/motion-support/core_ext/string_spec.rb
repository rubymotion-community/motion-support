describe "string" do
  describe "empty?" do
    it "an empty string is detected by empty?" do
      ''.empty?.should.be.true
    end

    it "a non-empty string is false according to empty?" do
      'something'.empty?.should.not.be.true
    end

    it "a blank string is false according to empty?" do
      ' '.empty?.should.not.be.true
    end
  end

  describe "constantize" do
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
    
    it "should lookup nested constant" do
      "Ace::Base::Case".constantize.should == Ace::Base::Case
    end
    
    it "should lookup nested absolute constant" do
      "::Ace::Base::Case".constantize.should == Ace::Base::Case
    end
    
    it "should lookup nested inherited constant" do
      "Ace::Base::Fase::Dice".constantize.should == Ace::Base::Fase::Dice
    end
    
    it "should lookup nested included constant" do
      "Ace::Gas::Case".constantize.should == Ace::Gas::Case
    end
    
    it "should lookup nested constant included into Object" do
      "Case::Dice".constantize.should == Case::Dice
    end
    
    it "should lookup nested absolute constant included into Object" do
      "Object::Case::Dice".constantize.should == Case::Dice
    end
    
    it "should lookup constant" do
      "String".constantize.should == String
    end
    
    it "should lookup absolute constant" do
      "::Ace".constantize.should == Ace
    end
    
    it "should return Object for empty string" do
      "".constantize.should == Object
    end
    
    it "should return Object for double colon" do
      "::".constantize.should == Object
    end
    
    it "should raise NameError for unknown constant" do
      lambda { "UnknownClass".constantize }.should.raise NameError
    end
    
    it "should raise NameError for unknown nested constant" do
      lambda { "UnknownClass::Ace".constantize }.should.raise NameError
      lambda { "UnknownClass::Ace::Base".constantize }.should.raise NameError
    end
    
    it "should raise NameError for invalid string" do
      lambda { "An invalid string".constantize }.should.raise NameError
      lambda { "InvalidClass\n".constantize }.should.raise NameError
    end
    
    it "should raise NameError for nested unknown constant in known constant" do
      lambda { "Ace::ConstantizeTestCases".constantize }.should.raise NameError
      lambda { "Ace::Base::ConstantizeTestCases".constantize }.should.raise NameError
      lambda { "Ace::Gas::Base".constantize }.should.raise NameError
      lambda { "Ace::Gas::ConstantizeTestCases".constantize }.should.raise NameError
    end
  end
end
