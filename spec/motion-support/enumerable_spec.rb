describe "enumerable" do
  describe "collect_with_index" do
    describe "on Array" do
      it "should return an empty array on an empty array" do
        [].collect_with_index { |x, i| x }.should == []
      end
    
      it "should yield an index for each element" do
        [1, 2, 3].collect_with_index { |x, i| [i, x] }.should == [[0, 1], [1, 2], [2, 3]]
      end
      
      it "should apply the block to each element" do
        [1, 2, 3].collect_with_index { |x, i| x * i }.should == [0, 2, 6]
      end
    end
    
    describe "on Hash" do
      it "should return an empty array on an empty hash" do
        {}.collect_with_index { |x, i| x }.should == []
      end
      
      it "should apply the block to each element" do
        result = {:foo => 1, :bar => 2, :baz => 3}.collect_with_index { |p, i| [p.first, p.last, i] }
        result.should == [[:foo, 1, 0], [:bar, 2, 1], [:baz, 3, 2]]
      end
    end
  end
end
