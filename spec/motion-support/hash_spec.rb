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

  it "reports an empty hash using empty?" do
    {:key => 'value'}.empty?.should.not.be.true
    {}.empty?.should.be.true
  end

  it "creates sub-hashes using except" do
    {:a => 'a', :b => 'b'}.except(:b)[:b].should.be.nil
    {:a => 'a', :b => 'b'}.except(:b).length.should == 1
  end
end
