describe "string" do
  describe "humanize" do
    it "handles dashes in text" do
      'text-with-dashes'.humanize.should == 'text with dashes'
    end

    it "doesn't add junk at end if trailing character is a dash" do
      'text-with-trailing-dash-'.humanize.should == 'text with trailing dash'
    end

    it "doesn't prepend junk if starting character is a dash" do
      '-text-with-leading-dash'.humanize.should == 'text with leading dash'
    end

    it "condenses multiple dashes to one space" do
      'text--with-multiple--dashes'.humanize.should == 'text with multiple dashes'
    end
  end

  describe "titleize" do
    it "translates text to title case" do
      'text-to-translate'.titleize.should == 'Text To Translate'
    end
  end

  describe "dasherize" do
    it 'handles strings with spaces' do
      'a normal string'.dasherize.should == 'a-normal-string'
    end

    it 'handles CamelCase strings' do
      'MyClass'.dasherize.should == 'my-class'
    end

    it 'handles snake_case strings' do
      'my_class'.dasherize.should == 'my-class'
    end
  end

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

  describe "camelize" do
    it 'a dashed string should convert to CamelCase' do
      'my-class'.camelize.should == 'MyClass'
    end

    it 'a snake_case string should convert to CamelCase' do
      'my_class'.camelize.should == 'MyClass'
    end

    it 'a conversion can be specified with lowercase first letter' do
      'my_cocoa_var'.camelize(false).should == 'myCocoaVar'
    end
  end

  describe "underscore" do
    it 'a camel-cased string can be converted to snake-case' do
      'MyClass'.underscore.should == 'my_class'
    end

    it 'a module scoped class is properly underscored' do
      'MyModule::MyClass'.underscore.should == 'my_module/my_class'
    end

    it 'properly underscores lowercase initial letter' do
      'aCocoaVariable'.underscore.should == 'a_cocoa_variable'
    end
  end

  describe "pluralize" do
    it "should return self if string is already plural" do
      "houses".pluralize.should == "houses"
      "trains".pluralize.should == "trains"
    end

    it "should return plural version for singular string" do
      "house".pluralize.should == "houses"
      "train".pluralize.should == "trains"
    end
  end

  describe "singularize" do
    it "should return self if string is already singular" do
      "house".singularize.should == "house"
      "train".singularize.should == "train"
    end

    it "should return singular version for plural string" do
      "houses".singularize.should == "house"
      "trains".singularize.should == "train"
    end
  end

  describe "classify" do
    it "should return classified version of underscored singular string" do
      "search_controller".classify.should == "SearchController"
    end

    it "should return classified version of underscored plural string" do
      "search_controllers".classify.should == "SearchController"
    end

    it "should return classified version of camelized singular string" do
      "SearchController".classify.should == "SearchController"
    end

    it "should return classified version of camelized plural string" do
      "SearchControllers".classify.should == "SearchController"
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
