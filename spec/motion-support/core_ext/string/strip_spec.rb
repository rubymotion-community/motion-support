describe "String" do
  describe "strip_heredoc" do
    it "should strip heredoc on an empty string" do
      ''.strip_heredoc.should == ''
    end

    it "should strip heredoc on a string with no lines" do
      'x'.strip_heredoc.should == 'x'
      '    x'.strip_heredoc.should == 'x'
    end

    it "should strip heredoc on a heredoc with no margin" do
      "foo\nbar".strip_heredoc.should == "foo\nbar"
      "foo\n  bar".strip_heredoc.should == "foo\n  bar"
    end

    it "should strip heredoc on a regular indented heredoc" do
      <<-EOS.strip_heredoc.should == "foo\n  bar\nbaz\n"
        foo
          bar
        baz
      EOS
    end

    it "should strip heredoc on a regular indented heredoc with blank lines" do
      <<-EOS.strip_heredoc.should == "foo\n  bar\n\nbaz\n"
        foo
          bar

        baz
      EOS
    end
  end
end
