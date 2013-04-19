describe "hash" do
  describe "reverse_merge" do
    before do
      @defaults = { :a => "x", :b => "y", :c => 10 }.freeze
      @options  = { :a => 1, :b => 2 }
      @expected = { :a => 1, :b => 2, :c => 10 }
    end

    it "should merge defaults into options, creating a new hash" do
      @options.reverse_merge(@defaults).should == @expected
      @options.should.not == @expected
    end

    it "should merge! defaults into options, replacing options" do
      merged = @options.dup
      merged.reverse_merge!(@defaults).should == @expected
      merged.should == @expected
    end

    it "should be an alias for reverse_merge!" do
      merged = @options.dup
      merged.reverse_update(@defaults).should == @expected
      merged.should == @expected
    end
  end
end
