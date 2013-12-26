describe "hash" do
  before do
    @hash = { :a => 1, :b => [ { :c => 2, :d => 3 }, :b ], :d => { :f => 4 } }
  end

  it "recursive deletes a top level key" do
    @hash.deep_delete_if { |k,v| k == :a }.should == { :b => [ { :c => 2, :d => 3 }, :b ], :d => { :f => 4 } }
  end

  it "recurisive deletes a key within an array" do
    @hash.deep_delete_if { |k,v| v == 2 }.should == { :a => 1, :b => [ { :d => 3 }, :b ], :d => { :f => 4 } }
  end

  it "recursive deletes a key within a hash" do
    @hash.deep_delete_if { |k,v| v == 4 }.should == { :a => 1, :b => [ { :c => 2, :d => 3 }, :b ], :d => {} }
  end
end
