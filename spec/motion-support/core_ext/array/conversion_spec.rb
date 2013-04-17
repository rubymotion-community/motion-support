describe 'array' do
  describe "to_sentence" do
    it "should convert plain array" do
      [].to_sentence.should == ""
      ['one'].to_sentence.should == "one"
      ['one', 'two'].to_sentence.should == "one and two"
      ['one', 'two', 'three'].to_sentence.should == "one, two, and three"
    end
    
    it "should convert sentence with words connector" do
      ['one', 'two', 'three'].to_sentence(:words_connector => ' ').should == "one two, and three"
      ['one', 'two', 'three'].to_sentence(:words_connector => ' & ').should == "one & two, and three"
      ['one', 'two', 'three'].to_sentence(:words_connector => nil).should == "onetwo, and three"
    end
    
    it "should convert sentence with last word connector" do
      ['one', 'two', 'three'].to_sentence(:last_word_connector => ', and also ').should == "one, two, and also three"
      ['one', 'two', 'three'].to_sentence(:last_word_connector => nil).should == "one, twothree"
      ['one', 'two', 'three'].to_sentence(:last_word_connector => ' ').should == "one, two three"
      ['one', 'two', 'three'].to_sentence(:last_word_connector => ' and ').should == "one, two and three"
    end
    
    it "should convert two-element array" do
      ['one', 'two'].to_sentence.should == "one and two"
      ['one', 'two'].to_sentence(:two_words_connector => ' ').should == "one two"
    end
    
    it "should convert one-element array" do
      ['one'].to_sentence.should == "one"
    end
    
    it "should create new object" do
      elements = ["one"]
      elements.to_sentence.object_id.should.not == elements[0].object_id
    end
    
    it "should convert non-string element" do
      [1].to_sentence.should == '1'
    end
    
    it "should not modify given hash" do
      options = { words_connector: ' ' }
      ['one', 'two', 'three'].to_sentence(options).should == "one two, and three"
      options.should == { words_connector: ' ' }
    end
  end
  
  describe "to_s" do
    it "should convert to database format" do
      collection = [
        Class.new { def id() 1 end }.new,
        Class.new { def id() 2 end }.new,
        Class.new { def id() 3 end }.new
      ]

      [].to_s(:db).should == "null"
      collection.to_s(:db).should == "1,2,3"
    end
  end
end
