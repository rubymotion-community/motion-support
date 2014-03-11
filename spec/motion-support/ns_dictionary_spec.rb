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

  def describe_with_bang(method, &block)
    bang_method = "#{method}!"

    describe(method) do
      it "should work for NSDictionary instances" do
        block.call(method)
      end
    end

    describe(bang_method) do
      it "should work for NSDictionary instances" do
        block.call(bang_method)
      end
    end
  end

  describe_with_bang "symbolize_keys" do |method|
    dict = NSMutableDictionary.alloc.init
    dict.setValue('bar', forKey:'foo')
    dict.send(method).should == { :foo => 'bar' }
  end

  describe_with_bang "deep_symbolize_keys" do |method|
    dict = NSMutableDictionary.alloc.init
    innerDict = NSMutableDictionary.alloc.init
    innerDict.setValue('foobar', forKey: 'bar')
    dict.setValue(innerDict, forKey:'foo')
    dict.send(method).should == {foo: {bar: 'foobar'}}
  end

  describe_with_bang "stringify_keys" do |method|
    dict = NSMutableDictionary.alloc.init
    dict.setValue('bar', forKey: :foo)
    dict.send(method).should == {'foo' => 'bar'}
  end

  describe_with_bang "deep_stringify_keys" do |method|
    dict = NSMutableDictionary.alloc.init
    innerDict = NSMutableDictionary.alloc.init
    innerDict.setValue('foobar', forKey: :bar)
    dict.setValue(innerDict, forKey: :foo)
    dict.send(method).should == {'foo' => {'bar' => 'foobar'}}
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
