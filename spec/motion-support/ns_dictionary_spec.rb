describe "NSDictionary" do
  describe "to_hash" do
    before do
      dict = NSMutableDictionary.alloc.init
      dict.setValue('bar', forKey:'foo')
      @hash = dict.to_hash
    end
    
    it "should convert NSDictionary to Hash" do
      @hash.class.should == Hash
    end
    
    it "should preserve all keys" do
      @hash.keys.should == ['foo']
    end
    
    it "should preserve all values" do
      @hash.values.should == ['bar']
    end
  end
  
  describe "symbolize_keys" do
    it "should work for NSDictionary instances" do
      dict = NSMutableDictionary.alloc.init
      dict.setValue('bar', forKey:'foo')
      dict.symbolize_keys.should == { :foo => 'bar' }
    end
  end
end
