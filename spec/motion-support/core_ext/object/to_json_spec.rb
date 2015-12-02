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

  describe "Time" do
    it "should return iso8601" do
      Time.new(2015, 12, 25, 1, 2, 3, '-05:00').utc.to_json.should == '"2015-12-25T06:02:03Z"'
    end
  end

  describe "Date" do
    it "should return iso8601" do
      Date.new(2015, 12, 25).to_json.should == '"2015-12-25"'
    end
  end

  describe "array" do
    it "should convert mixed type array" do
      input = [true, false, nil, {:foo => :bar}, 'fizz', '', Time.new(2015, 12, 25, 1, 2, 3, '-05:00').utc, Date.new(2015, 12, 25)]
      output = '[true,false,null,{"foo":"bar"},"fizz","","2015-12-25T06:02:03Z","2015-12-25"]'

      input.to_json.should == output
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
