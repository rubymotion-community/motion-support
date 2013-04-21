class ArrayToParam < String
  def to_param
    "#{self}1"
  end
end

class HashToParam < String
  def to_param
    "#{self}-1"
  end
end

describe "to_param" do
  describe "object" do
    it "should delegate to to_s" do
      foo = Object.new
      def foo.to_s; 'foo' end
      foo.to_param.should == 'foo'
    end
  end

  describe "nil" do
    it "should return self" do
      nil.to_param.should == nil
    end
  end

  describe "true, false" do
    it "should return self" do
      true.to_param.should == true
      false.to_param.should == false
    end
  end
  
  describe "array" do
    it "should convert string array" do
      %w().to_param.should == ''
      %w(hello world).to_param.should == 'hello/world'
      %w(hello 10).to_param.should == 'hello/10'
    end

    it "should convert number array" do
      [10, 20].to_param.should == '10/20'
    end

    it "should convert custom object array" do
      [ArrayToParam.new('custom'), ArrayToParam.new('param')].to_param.should == 'custom1/param1'
    end
  end

  describe "hash" do
    it "should convert a string hash" do
      {}.to_param.should == ''
      { :hello => "world" }.to_param.should == 'hello=world'
      { "hello" => 10 }.to_param.should == 'hello=10'
      {:hello => "world", "say_bye" => true}.to_param.should == 'hello=world&say_bye=true'
    end

    it "should convert a number hash" do
      {10 => 20, 30 => 40, 50 => 60}.to_param.should == '10=20&30=40&50=60'
    end

    it "should convert an object hash" do
      {HashToParam.new('custom') => HashToParam.new('param'), HashToParam.new('custom2') => HashToParam.new('param2')}.to_param.should == 'custom-1=param-1&custom2-1=param2-1'
    end

    it "should escape keys and values" do
      { 'param 1' => 'A string with / characters & that should be ? escaped' }.to_param.should == 'param+1=A+string+with+%2F+characters+%26+that+should+be+%3F+escaped'
    end

    it "should order keys in ascending order" do
      Hash[*%w(b 1 c 0 a 2)].to_param.should == 'a=2&b=1&c=0'
    end
  end
end
