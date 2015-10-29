describe ".to_json" do
  describe "object" do
    it "should serialize attributes" do
      foo = Object.new
      class << foo
        attr_accessor :test
      end
      foo.test = 'bar'

      foo.to_json.should == '{"test":"bar"}'
    end
  end

  describe "nil" do
    it "should return null" do
      nil.to_json.should == 'null'
    end
  end

  describe "true, false" do
    it "should return self as string" do
      true.to_json.should == 'true'
      false.to_json.should == 'false'
    end
  end

  describe "string" do
    it "should escape the required characters" do
      'A string with special \ " &'.to_json.should == "\"A string with special \\\\ \\\" \\u0026\""
    end
  end

  describe "numeric" do
    it "should return self" do
      2.days.to_json.should == 172800
    end
  end

  describe "array" do
    it "should convert mixed type array" do
      [true, false, nil, {:foo => :bar}, 'fizz', ''].to_json.should == '[true,false,null,{"foo":"bar"},"fizz",""]'
    end
  end

  describe "hash" do
    it "should convert a string hash" do
      {}.to_json.should == '{}'
      { :hello => :world }.to_json.should == '{"hello":"world"}'
      { :hello => "world" }.to_json.should == '{"hello":"world"}'
      { "hello" => 10 }.to_json.should == '{"hello":10}'
      { "hello" => { "world" => "hi" } }.to_json.should == '{"hello":{"world":"hi"}}'
      {:hello => "world", "say_bye" => true}.to_json.should == '{"hello":"world","say_bye":true}'
    end

    it "should convert a number hash" do
      {10 => 20, 30 => 40, 50 => 60}.to_json.should == '{"10":20,"30":40,"50":60}'
    end
  end
end
