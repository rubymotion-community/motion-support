describe "String" do
  describe "indent" do
    it "should not indent strings that only contain newlines (edge cases)" do
      ['', "\n", "\n" * 7].each do |str|
        str.indent!(8).should.be.nil
        str.indent(8).should == str
        str.indent(1, "\t").should == str
      end
    end

    it "should indent by default with spaces if the existing indentation uses them" do
      "foo\n  bar".indent(4).should == "    foo\n      bar"
    end

    it "should indent by default with tabs if the existing indentation uses them" do
      "foo\n\t\bar".indent(1).should == "\tfoo\n\t\t\bar"
    end

    it "should indent by default with spaces as a fallback if there is no indentation" do
      "foo\nbar\nbaz".indent(3).should == "   foo\n   bar\n   baz"
    end

    # Nothing is said about existing indentation that mixes spaces and tabs, so
    # there is nothing to test.

    it "should use the indent char if passed" do
      <<ACTUAL.indent(4, '.').should == <<EXPECTED
  def some_method(x, y)
    some_code
  end
ACTUAL
....  def some_method(x, y)
....    some_code
....  end
EXPECTED

      <<ACTUAL.indent(2, '&nbsp;').should == <<EXPECTED
&nbsp;&nbsp;def some_method(x, y)
&nbsp;&nbsp;&nbsp;&nbsp;some_code
&nbsp;&nbsp;end
ACTUAL
&nbsp;&nbsp;&nbsp;&nbsp;def some_method(x, y)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;some_code
&nbsp;&nbsp;&nbsp;&nbsp;end
EXPECTED
    end

    it "should not indent blank lines by default" do
      "foo\n\nbar".indent(1).should == " foo\n\n bar"
    end

    it "should indent blank lines if told so" do
      "foo\n\nbar".indent(1, nil, true).should == " foo\n \n bar"
    end
  end
end
