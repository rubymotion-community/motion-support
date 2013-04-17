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
  
  describe "sum" do
    it "should return the sum of an integer array" do
      [5, 15, 10].sum.should == 30
    end
    
    it "should concatenate strings in a string array" do
      ['foo', 'bar'].sum.should == "foobar"
    end
    
    it "should concatenate arrays" do
      [[1, 2], [3, 1, 5]].sum.should == [1, 2, 3, 1, 5]
    end
    
    it "should yield a block to each element before summing if given" do
      [1, 2, 3].sum { |p| p * 2 }.should == 12
    end
    
    it "should allow a custom result for an empty list" do
      [].sum("empty") { |i| i.amount }.should == "empty"
    end
  end
  
  describe "index_by" do
    class Person < Struct.new(:first_name, :last_name)
    end
    
    before do
      @peter = Person.new('Peter', 'Griffin')
      @homer = Person.new('Homer', 'Simpson')
    end
    
    it "should create hash with keys given by block result" do
      [@peter, @homer].index_by { |x| x.first_name }.should == { 'Peter' => @peter, 'Homer' => @homer }
    end
    
    it "should create enumerator if no block is given" do
      [@peter, @homer].index_by.should.is_a Enumerator
    end
  end
  
  describe "many?" do
    it "should return false for an empty enumerable" do
      [].many?.should == false
      {}.many?.should == false
    end
    
    it "should return false for an enumerable with only one element" do
      [1].many?.should == false
      {:foo => :bar}.many?.should == false
    end
    
    it "should return true for an enumerable with more than one element" do
      [1, 2].many?.should == true
      [1, 2, 3].many?.should == true
      {:foo => :bar, :baz => :bingo}.many?.should == true
      {:a => :b, :c => :d, :e => :f}.many?.should == true
    end
    
    it "should return false if there are less than two elements satisfying the block if given" do
      [1].many? { |x| x * 10 > 100 }.should == false
      [1, 2, 3, 4, 5].many? { |x| x >= 5 }.should == false
    end
    
    it "should return true if there is more than one element satisfying the block if given" do
      [1, 2, 3, 4, 5].many? { |x| x < 4 }.should == true
    end
  end
  
  describe "exclude?" do
    it "should return true if the element is not in the array" do
      [1, 2, 3].exclude?(4).should == true
    end
    
    it "should return false if the element is in the array" do
      [1, 2, 3].exclude?(2).should == false
    end
    
    it "should always return true for an empty array" do
      [].exclude?(rand).should == true
    end
  end
end

describe "Range" do
  describe "sum" do
    it "should return the sum of integers in an inclusive range" do
      (3..5).sum.should == 12
    end
    
    it "should return the sum of integers in an exclusive range" do
      (3...5).sum.should == 7
    end
    
    it "should return zero for an empty range" do
      (1...1).sum.should == 0
    end
    
    it "should return custom identity for an empty range if given" do
      (1...1).sum("empty").should == "empty"
    end
  end
end
