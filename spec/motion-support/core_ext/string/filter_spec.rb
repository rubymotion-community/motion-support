describe "String" do
  describe "filters" do
    describe "squish" do
      before do
        @original = %{ A string surrounded by spaces, with tabs(\t\t),
          newlines(\n\n), unicode nextlines(\u0085\u0085) and many spaces(  ). }

        @expected = "A string surrounded by spaces, with tabs( ), newlines( )," \
          " unicode nextlines( ) and many spaces( )."
      end
      
      it "should squish string" do
        @original.squish.should == @expected
        @original.should.not == @expected
      end

      it "should squish! string" do
        @original.squish!.should == @expected
        @original.should == @expected
      end
    end
    
    describe "truncate" do
      it "should truncate string" do
        "Hello World!".truncate(12).should == "Hello World!"
        "Hello World!!".truncate(12).should == "Hello Wor..."
      end
      
      it "should truncate with omission and seperator" do
        "Hello World!".truncate(10, :omission => "[...]").should == "Hello[...]"
        "Hello Big World!".truncate(13, :omission => "[...]", :separator => ' ').should == "Hello[...]"
        "Hello Big World!".truncate(14, :omission => "[...]", :separator => ' ').should == "Hello Big[...]"
        "Hello Big World!".truncate(15, :omission => "[...]", :separator => ' ').should == "Hello Big[...]"
      end
      
      it "should truncate with omission and regexp seperator" do
        "Hello Big World!".truncate(13, :omission => "[...]", :separator => /\s/).should == "Hello[...]"
        "Hello Big World!".truncate(14, :omission => "[...]", :separator => /\s/).should == "Hello Big[...]"
        "Hello Big World!".truncate(15, :omission => "[...]", :separator => /\s/).should == "Hello Big[...]"
      end
      
      it "should truncate multibyte" do
        "\354\225\204\353\246\254\353\236\221 \354\225\204\353\246\254 \354\225\204\353\235\274\353\246\254\354\230\244".force_encoding(Encoding::UTF_8).truncate(10).should ==
          "\354\225\204\353\246\254\353\236\221 \354\225\204\353\246\254 ...".force_encoding(Encoding::UTF_8)
      end
    end
  end
end
