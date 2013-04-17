describe "hash" do
  before do
    @hash_1 = { :a => "a", :b => "b", :c => { :c1 => "c1", :c2 => "c2", :c3 => { :d1 => "d1" } } }
    @hash_2 = { :a => 1, :c => { :c1 => 2, :c3 => { :d2 => "d2" } } }
  end
  
  describe "deep_merge" do
    it "should deep merge" do
      expected = { :a => 1, :b => "b", :c => { :c1 => 2, :c2 => "c2", :c3 => { :d1 => "d1", :d2 => "d2" } } }
      @hash_1.deep_merge(@hash_2).should == expected
    end
    
    it "should deep merge with block" do
      expected = { :a => [:a, "a", 1], :b => "b", :c => { :c1 => [:c1, "c1", 2], :c2 => "c2", :c3 => { :d1 => "d1", :d2 => "d2" } } }
      (@hash_1.deep_merge(@hash_2) { |k,o,n| [k, o, n] }).should == expected
    end
  end
  
  describe "deep_merge!" do
    it "should deep merge" do
      expected = { :a => 1, :b => "b", :c => { :c1 => 2, :c2 => "c2", :c3 => { :d1 => "d1", :d2 => "d2" } } }
      @hash_1.deep_merge!(@hash_2)
      @hash_1.should == expected
    end
    
    it "should deep merge with block" do
      expected = { :a => [:a, "a", 1], :b => "b", :c => { :c1 => [:c1, "c1", 2], :c2 => "c2", :c3 => { :d1 => "d1", :d2 => "d2" } } }
      @hash_1.deep_merge!(@hash_2) { |k,o,n| [k, o, n] }
      @hash_1.should == expected
    end
  end
end
