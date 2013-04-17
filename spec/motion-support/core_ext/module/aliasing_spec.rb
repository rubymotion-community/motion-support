module Aliasing
  class File
  public
    def open(file)
    end
    def open_with_internet(url)
      open_without_internet(url)
    end
    alias_method_chain :open, :internet
  
  protected
    def exist?(file)
    end
    def exist_with_internet?(url)
      exist_without_internet?(url)
    end
    alias_method_chain :exist?, :internet
  
  private
    def remove!(file)
    end
    def remove_with_internet!(url)
      remove_without_internet!(url)
    end
    alias_method_chain :remove!, :internet
  end
  
  class Content
    attr_accessor :title, :Data

    def initialize
      @title, @Data = nil, nil
    end

    def title?
      !title.nil?
    end

    def Data?
      !self.Data.nil?
    end
  end

  class Email < Content
    alias_attribute :subject, :title
    alias_attribute :body, :Data
  end
end

describe "module" do
  describe "alias_method_chain" do
    it "should define 'without' method" do
      Aliasing::File.new.should.respond_to :open_without_internet
    end
    
    it "should respond to original method" do
      Aliasing::File.new.should.respond_to :open
    end
    
    it "should respond to 'with' method" do
      Aliasing::File.new.should.respond_to :open_with_internet
    end
    
    it "should preserve question punctuation" do
      Aliasing::File.new.should.respond_to :exist_without_internet?
    end
    
    it "should preserve bang punctuation" do
      # Ruby objects don't respond to private methods
      Aliasing::File.new.should.not.respond_to :remove_without_internet!
    end
    
    it "should keep public methods public" do
      Aliasing::File.new.public_methods.should.include :"open_without_internet:"
    end
    
    it "should keep protected methods protected" do
      Aliasing::File.new.protected_methods.should.include :"exist_without_internet?:"
    end
    
    it "should keep private methods private" do
      Aliasing::File.new.private_methods.should.include :"remove_without_internet!:"
    end
  end
  
  describe "alias_attribute" do
    before do
      @email = Aliasing::Email.new
    end
    
    describe "getter" do
      it "should exist" do
        lambda { @email.subject }.should.not.raise
      end
      
      it "should read" do
        @email.title = "hello"
        @email.subject.should == "hello"
      end
      
      it "should read from uppercase method" do
        @email.body = "world"
        @email.Data.should == "world"
      end
    end
    
    describe "setter" do
      it "should exist" do
        lambda { @email.subject = "hello" }.should.not.raise
      end
      
      it "should write" do
        @email.subject = "hello"
        @email.title.should == "hello"
      end
      
      it "should write to uppercase method" do
        @email.Data = "world"
        @email.body.should == "world"
      end
    end
    
    describe "question method" do
      it "should exist" do
        lambda { @email.subject? }.should.not.raise
      end
      
      it "should return false for nil attribute" do
        @email.subject?.should == false
      end
      
      it "should return true for non-nil attribute" do
        @email.title = "hello"
        @email.subject?.should == true
      end
      
      it "should return true for non-nil uppercase attribute" do
        @email.body = "hello"
        @email.Data?.should == true
      end
    end
  end
end
