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

  describe "with_indifferent_access" do
    it "should work for NSDictionary instances" do
      dict = NSMutableDictionary.alloc.init
      dict.setValue('bar', forKey:'foo')
      dict_indifferent = dict.with_indifferent_access
      dict_indifferent['foo'].should == 'bar'
      dict_indifferent[:foo].should == dict_indifferent['foo']
    end

    it "should work with nested NSDictionary instances" do
      dict = NSMutableDictionary.alloc.init
      dict_inner = NSMutableDictionary.alloc.init
      dict_inner.setValue('value', forKey: 'key')
      dict.setValue('bar', forKey:'foo')
      dict.setValue(dict_inner, forKey: 'inner')

      dict_indifferent = dict.with_indifferent_access
      inner_indifferent = dict_indifferent['inner']
      dict_indifferent[:inner].should == inner_indifferent
      inner_indifferent['key'].should == dict_inner['key']
      inner_indifferent[:key].should == inner_indifferent['key']
    end
  end
end
