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

  describe "blank?" do
    it "an empty string should be blank" do
      ''.should.be.blank
    end

    it "a string containing only whitespace should be blank" do
      '  '.should.be.blank
    end

    it "a string with content is not blank" do
      'abc'.should.not.be.blank
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
    class SearchController; end

    it "makes a constant class name from a suitable string" do
      "SearchControllers".classify.constantize.should == SearchController
    end
  end
end
