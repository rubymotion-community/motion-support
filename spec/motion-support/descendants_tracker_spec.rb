module DescendantsTrackerSpec
  class Parent
    extend MotionSupport::DescendantsTracker
  end

  class Child1 < Parent
  end

  class Child2 < Parent
  end

  class Grandchild1 < Child1
  end

  class Grandchild2 < Child1
  end

  ALL = [Parent, Child1, Child2, Grandchild1, Grandchild2]
end

describe "DescendatsTracker" do
  describe "descendants" do
    it "should get all descendants from parent class" do
      [DescendantsTrackerSpec::Child1, DescendantsTrackerSpec::Child2, DescendantsTrackerSpec::Grandchild1, DescendantsTrackerSpec::Grandchild2].should == DescendantsTrackerSpec::Parent.descendants
    end
    
    it "should get descendants from subclass" do
      [DescendantsTrackerSpec::Grandchild1, DescendantsTrackerSpec::Grandchild2].should == DescendantsTrackerSpec::Child1.descendants
    end
    
    it "should return empty array for leaf class" do
      [].should == DescendantsTrackerSpec::Child2.descendants
    end
  end

  describe "direct_descendants" do
    it "should get direct descendants from parent class" do
      [DescendantsTrackerSpec::Child1, DescendantsTrackerSpec::Child2].should == DescendantsTrackerSpec::Parent.direct_descendants
    end
    
    it "should get direct descendants from subclass" do
      [DescendantsTrackerSpec::Grandchild1, DescendantsTrackerSpec::Grandchild2].should == DescendantsTrackerSpec::Child1.direct_descendants
    end
    
    it "should return empty array for leaf class" do
      [].should == DescendantsTrackerSpec::Child2.direct_descendants
    end
  end

  describe "clear" do
    it "should remove all tracked descendants" do
      MotionSupport::DescendantsTracker.clear
      DescendantsTrackerSpec::ALL.each do |k|
        MotionSupport::DescendantsTracker.descendants(k).should.be.empty
      end
    end
  end
end
