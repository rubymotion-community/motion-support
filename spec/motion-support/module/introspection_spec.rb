module ModuleIntrospection
  module Foo
    module Bar
    end
  end
  module Baz
  end
end
ModuleIntrospectionAlias = ModuleIntrospection::Foo

describe "module" do
  describe "introspection" do
    describe "parent_name" do
      it "should return nil for top-level module" do
        ModuleIntrospection.parent_name.should.be.nil
      end
      
      it "should return direct parent for nested module" do
        ModuleIntrospection::Foo.parent_name.should == "ModuleIntrospection"
      end
      
      it "should return nil for anonymous module" do
        Module.new.parent_name.should.be.nil
      end
      
      it "should return original parent name for module alias" do
        ModuleIntrospectionAlias.parent_name.should == "ModuleIntrospection"
      end
    end
    
    describe "parent" do
      it "should return Object for top-level module" do
        ModuleIntrospection.parent.should == Object
      end
      
      it "should return direct parent for nested module" do
        ModuleIntrospection::Foo.parent.should == ModuleIntrospection
      end
      
      it "should return nil for anonymous module" do
        Module.new.parent.should == Object
      end
      
      it "should return original parent for module alias" do
        ModuleIntrospectionAlias.parent.should == ModuleIntrospection
      end
    end
    
    describe "parents" do
      it "should return Object for top-level module" do
        ModuleIntrospection.parents.should == [Object]
      end
      
      it "should return parents for nested module" do
        ModuleIntrospection::Foo::Bar.parents.should == [ModuleIntrospection::Foo, ModuleIntrospection, Object]
      end
      
      it "should return original parents for module alias" do
        ModuleIntrospectionAlias.parents.should == [ModuleIntrospection, Object]
      end
    end
    
    describe "local_constants" do
      it "should return all direct constants within the module as symbols" do
        ModuleIntrospection.local_constants.should.include :Foo
        ModuleIntrospection.local_constants.should.include :Baz
      end
    end
  end
end
