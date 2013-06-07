describe "Numeric" do
  describe "conversions" do
    describe "phone" do
      it "should format phone number without area code" do
        5551234.to_s(:phone).should == "555-1234"
      end
      
      it "should format long number without area code" do
        225551212.to_s(:phone).should == "22-555-1212"
        8005551212.to_s(:phone).should == "800-555-1212"
      end
      
      it "should format phone number with area code" do
        8005551212.to_s(:phone, :area_code => true).should == "(800) 555-1212"
      end
      
      it "should format phone number with custom delimiter" do
        8005551212.to_s(:phone, :delimiter => " ").should == "800 555 1212"
        5551212.to_s(:phone, :delimiter => '.').should == "555.1212"
      end
      
      it "should append extension to phone number" do
        8005551212.to_s(:phone, :area_code => true, :extension => 123).should == "(800) 555-1212 x 123"
      end
      
      it "should not append whitespace as extension to the phone number" do
        8005551212.to_s(:phone, :extension => "  ").should == "800-555-1212"
      end
      
      it "should format phone number with country code" do
        8005551212.to_s(:phone, :country_code => 1).should == "+1-800-555-1212"
        225551212.to_s(:phone, :country_code => 45).should == "+45-22-555-1212"
      end
      
      it "should format phone number with country code and empty delimiter" do
        8005551212.to_s(:phone, :country_code => 1, :delimiter => '').should == "+18005551212"
      end
    end
  end
end
