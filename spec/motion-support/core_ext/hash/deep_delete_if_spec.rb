describe "hash" do
  before do
    @hash = { :a => 1, :b => [ { :c => 2, :d => 3 }, :b ], :d => { :f => 4 } }
  end

  describe "deep_delete_if" do
    it "should delete a top level key recursively" do
      @hash.deep_delete_if { |k,v| k == :a }.should == { :b => [ { :c => 2, :d => 3 }, :b ], :d => { :f => 4 } }
    end

    it "should delete a key within an array recursively" do
      @hash.deep_delete_if { |k,v| v == 2 }.should == { :a => 1, :b => [ { :d => 3 }, :b ], :d => { :f => 4 } }
    end

    it "should delete a key within a hash recursively" do
      @hash.deep_delete_if { |k,v| v == 4 }.should == { :a => 1, :b => [ { :c => 2, :d => 3 }, :b ], :d => {} }
    end
  end
end
