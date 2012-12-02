describe "hash" do
  it "should return copy with symbolized keys" do
    { 'foo' => 'bar', 'bla' => 'blub' }.symbolize_keys.should == { :foo => 'bar', :bla => 'blub' }
  end
  
  it "should not modify keys that can not be symbolized" do
    { :foo => 'bar', 1 => 'blub' }.symbolize_keys.should == { :foo => 'bar', 1 => 'blub' }
  end
  
  it "should symbolize keys in place" do
    hash = { 'foo' => 'bar', 'bla' => 'blub' }
    hash.symbolize_keys!
    hash.should == { :foo => 'bar', :bla => 'blub' }
  end
end
