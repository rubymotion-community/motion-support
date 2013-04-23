describe "String" do
  describe "Inflections" do
    describe "singularize" do
      InflectorTestCases::SingularToPlural.each do |singular, plural|
        it "should pluralize singular #{singular}" do
          singular.pluralize.should == plural
        end
      end
      
      it "should pluralize plural" do
        "plurals".pluralize.should == "plurals"
      end
      
      it "should pluralize with number" do
        "blargle".pluralize(0).should == "blargles"
        "blargle".pluralize(1).should == "blargle"
        "blargle".pluralize(2).should == "blargles"
      end
    end
    
    describe "singularize" do
      InflectorTestCases::SingularToPlural.each do |singular, plural|
        it "should singularize plural #{plural}" do
          plural.singularize.should == singular
        end
      end
    end
    
    describe "titleize" do
      InflectorTestCases::MixtureToTitleCase.each do |before, titleized|
        it "should titleize #{before}" do
          before.titleize.should == titleized
        end
      end
    end
    
    describe "camelize" do
      InflectorTestCases::CamelToUnderscore.each do |camel, underscore|
        it "should camelize #{underscore}" do
          underscore.camelize.should == camel
        end
      end

      it "should lower-camelize" do
        'Capital'.camelize(:lower).should == 'capital'
      end
    end
    
    describe "dasherize" do
      InflectorTestCases::UnderscoresToDashes.each do |underscored, dasherized|
        it "should dasherize #{underscored}" do
          underscored.dasherize.should == dasherized
        end
      end
    end
    
    describe "underscore" do
      InflectorTestCases::CamelToUnderscore.each do |camel, underscore|
        it "should underscore #{camel}" do
          camel.underscore.should == underscore
        end
      end
      
      it "should underscore acronyms" do
        "HTMLTidy".underscore.should == "html_tidy"
        "HTMLTidyGenerator".underscore.should == "html_tidy_generator"
      end

      InflectorTestCases::UnderscoreToLowerCamel.each do |underscored, lower_camel|
        it "should lower-camelize #{underscored}" do
          underscored.camelize(:lower).should == lower_camel
        end
      end
    end
    
    it "should demodulize" do
      "MyApplication::Billing::Account".demodulize.should == "Account"
    end

    it "should deconstantize" do
      "MyApplication::Billing::Account".deconstantize.should == "MyApplication::Billing"
    end
    
    describe "foreign_key" do
      InflectorTestCases::ClassNameToForeignKeyWithUnderscore.each do |klass, foreign_key|
        it "should build foreign key from #{klass}" do
          klass.foreign_key.should == foreign_key
        end
      end

      InflectorTestCases::ClassNameToForeignKeyWithoutUnderscore.each do |klass, foreign_key|
        it "should build foreign key from #{klass} without underscore" do
          klass.foreign_key(false).should == foreign_key
        end
      end
    end

    describe "tableize" do
      InflectorTestCases::ClassNameToTableName.each do |class_name, table_name|
        it "should tableize #{class_name}" do
          class_name.tableize.should == table_name
        end
      end
    end

    describe "classify" do
      InflectorTestCases::ClassNameToTableName.each do |class_name, table_name|
        it "should classify #{table_name}" do
          table_name.classify.should == class_name
        end
      end
    end

    describe "humanize" do
      InflectorTestCases::UnderscoreToHuman.each do |underscore, human|
        it "should humanize #{underscore}" do
          underscore.humanize.should == human
        end
      end
    end
    
    describe "constantize" do
      extend ConstantizeTestCases
    
      it "should constantize" do
        run_constantize_tests_on do |string|
          string.constantize
        end
      end
    end
  
    describe "safe_constantize" do
      extend ConstantizeTestCases
    
      it "should safe_constantize" do
        run_safe_constantize_tests_on do |string|
          string.safe_constantize
        end
      end
    end
  end
end
