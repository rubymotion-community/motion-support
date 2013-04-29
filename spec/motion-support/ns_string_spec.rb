describe "NSString" do
  before do
    @string = NSString.stringWithString("ruby_motion")
  end
  
  describe "to_s" do
    it "should convert NSDictionary to Hash" do
      @string.to_s.class.should == String
    end
    
    it "should preserve the value" do
      @string.to_s.should == @string
    end
  end
  
  describe "at" do
    it "should return character at NSString position" do
      @string.at(0).should == 'r'
    end
  end
  
  describe "blank?" do
    it "should be true for empty NSString" do
      NSString.stringWithString("").blank?.should == true
    end
    
    it "should be false for non-empty NSString" do
      @string.blank?.should == false
    end
  end
  
  describe "camelize" do
    it "should camelize NSString" do
      @string.camelize.should == "RubyMotion"
    end
  end
  
  describe "classify" do
    it "should classify NSString" do
      @string.classify.should == "RubyMotion"
    end
  end
  
  describe "constantize" do
    it "should constantize NSString" do
      NSString.stringWithString("Object").constantize.should == Object
    end
  end
  
  describe "dasherize" do
    it "should dasherize NSString" do
      @string.dasherize.should == "ruby-motion"
    end
  end
  
  describe "deconstantize" do
    it "should deconstantize NSString" do
      NSString.stringWithString("Ruby::Motion").deconstantize.should == "Ruby"
    end
  end
  
  describe "demodulize" do
    it "should demodulize NSString" do
      NSString.stringWithString("Ruby::Motion").demodulize.should == "Motion"
    end
  end
  
  describe "exclude?" do
    it "should return true if NSString excludes substring" do
      @string.exclude?("foo").should == true
      @string.exclude?("ruby").should == false
    end
  end
  
  describe "first" do
    it "should return first character NSString" do
      @string.first.should == "r"
    end
  end
  
  describe "foreign_key" do
    it "should return NSString" do
      @string.foreign_key.should == "ruby_motion_id"
    end
  end
  
  describe "from" do
    it "should return substring of NSString starting at position" do
      @string.from(5).should == "motion"
    end
  end
  
  describe "humanize" do
    it "should humanize NSString" do
      @string.humanize.should == "Ruby motion"
    end
  end
  
  describe "indent" do
    it "should indent NSString" do
      @string.indent(2).should == "  ruby_motion"
    end
  end
  
  describe "indent!" do
    it "should indent NSString in place" do
      @string.indent!(2).should == "  ruby_motion"
    end
  end
  
  describe "last" do
    it "should return last character of NSString" do
      @string.last.should == "n"
    end
  end
  
  describe "pluralize" do
    it "should pluralize NSString" do
      NSString.stringWithString("thing").pluralize.should == "things"
    end
  end
  
  describe "safe_constantize" do
    it "should safe_constantize NSString" do
      NSString.stringWithString("Object").safe_constantize.should == Object
    end
  end
  
  describe "singularize" do
    it "should singularize NSString" do
      NSString.stringWithString("things").singularize.should == "thing"
    end
  end
  
  describe "squish" do
    it "should squish NSString" do
      NSString.stringWithString(" ruby\n  motion").squish.should == "ruby motion"
    end
  end
  
  describe "squish!" do
    it "should squish NSString in place" do
      NSString.stringWithString(" ruby\n  motion").squish!.should == "ruby motion"
    end
  end
  
  describe "strip_heredoc" do
    it "should strip heredoc NSString" do
      NSString.stringWithString("  ruby\n  motion").strip_heredoc.should == "ruby\nmotion"
    end
  end
  
  describe "tableize" do
    it "should tableize NSString" do
      @string.tableize.should == "ruby_motions"
    end
  end
  
  describe "titleize" do
    it "should titleize NSString" do
      @string.titleize.should == "Ruby Motion"
    end
  end
  
  describe "to" do
    it "should return substring of NSString up to position" do
      @string.to(3).should == "ruby"
    end
  end
  
  describe "truncate" do
    it "should truncate NSString" do
      @string.truncate(5).should == "ru..."
    end
  end
  
  describe "underscore" do
    it "should underscore NSString" do
      NSString.stringWithString("RubyMotion").underscore.should == "ruby_motion"
    end
  end
end
