module RemoveMethodSpec
  class A
    def do_something
      return 1
    end
  end
end

describe "module" do
  describe "remove_method" do
    it "should remove a method from an object" do
      RemoveMethodSpec::A.class_eval {
        self.remove_possible_method(:do_something)
      }
      RemoveMethodSpec::A.new.should.not.respond_to :do_something
    end

    def test_redefine_method_in_an_object
      RemoveMethodSpec::A.class_eval {
        self.redefine_method(:do_something) { return 100 }
      }
      RemoveMethodSpec::A.new.do_something.should == 100
    end
  end
end
