describe "NumberHelper" do
  class TestClassWithInstanceNumberHelpers
    include MotionSupport::NumberHelper
  end

  class TestClassWithClassNumberHelpers
    extend MotionSupport::NumberHelper
  end

  before do
    @instance_with_helpers = TestClassWithInstanceNumberHelpers.new
  end
  
  describe "number_to_phone" do
    it "should convert number to phone" do
      [@instance_with_helpers, TestClassWithClassNumberHelpers, MotionSupport::NumberHelper].each do |number_helper|
        number_helper.number_to_phone(5551234).should == "555-1234"
        number_helper.number_to_phone(8005551212).should == "800-555-1212"
        number_helper.number_to_phone(8005551212, {:area_code => true}).should == "(800) 555-1212"
        number_helper.number_to_phone("", {:area_code => true}).should == ""
        number_helper.number_to_phone(8005551212, {:delimiter => " "}).should == "800 555 1212"
        number_helper.number_to_phone(8005551212, {:area_code => true, :extension => 123}).should == "(800) 555-1212 x 123"
        number_helper.number_to_phone(8005551212, :extension => "  ").should == "800-555-1212"
        number_helper.number_to_phone(5551212, :delimiter => '.').should == "555.1212"
        number_helper.number_to_phone("8005551212").should == "800-555-1212"
        number_helper.number_to_phone(8005551212, :country_code => 1).should == "+1-800-555-1212"
        number_helper.number_to_phone(8005551212, :country_code => 1, :delimiter => '').should == "+18005551212"
        number_helper.number_to_phone(225551212).should == "22-555-1212"
        number_helper.number_to_phone(225551212, :country_code => 45).should == "+45-22-555-1212"
      end
    end
    
    it "should return nil when given nil" do
      [@instance_with_helpers, TestClassWithClassNumberHelpers, MotionSupport::NumberHelper].each do |number_helper|
        number_helper.number_to_phone(nil).should.be.nil
      end
    end
    
    it "should not mutate options hash" do
      [@instance_with_helpers, TestClassWithClassNumberHelpers, MotionSupport::NumberHelper].each do |number_helper|
        options = { 'raise' => true }

        number_helper.number_to_phone(1, options)
        options.should == { 'raise' => true }
      end
    end
    
    it "should return non-numeric parameter unchanged" do
      [@instance_with_helpers, TestClassWithClassNumberHelpers, MotionSupport::NumberHelper].each do |number_helper|
        number_helper.number_to_phone("x", :country_code => 1, :extension => 123).should == "+1-x x 123"
        number_helper.number_to_phone("x").should == "x"
      end
    end
  end
end
