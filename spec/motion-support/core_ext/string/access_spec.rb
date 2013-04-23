describe "String" do
  describe "access" do
    it "should access" do
      s = "hello"
      s.at(0).should == "h"

      s.from(2).should == "llo"
      s.to(2).should == "hel"

      s.first.should == "h"
      s.first(2).should == "he"
      s.first(0).should == ""

      s.last.should == "o"
      s.last(3).should == "llo"
      s.last(10).should == "hello"
      s.last(0).should == ""

      'x'.first.should == 'x'
      'x'.first(4).should == 'x'

      'x'.last.should == 'x'
      'x'.last(4).should == 'x'
    end

    it "should access returns a real string" do
      hash = {}
      hash["h"] = true
      hash["hello123".at(0)] = true
      hash.keys.should == %w(h)

      hash = {}
      hash["llo"] = true
      hash["hello".from(2)] = true
      hash.keys.should == %w(llo)

      hash = {}
      hash["hel"] = true
      hash["hello".to(2)] = true
      hash.keys.should == %w(hel)

      hash = {}
      hash["hello"] = true
      hash["123hello".last(5)] = true
      hash.keys.should == %w(hello)

      hash = {}
      hash["hello"] = true
      hash["hello123".first(5)] = true
      hash.keys.should == %w(hello)
    end
  end
end
