class EmptyTrue
  def empty?() true; end
end

class EmptyFalse
  def empty?() false; end
end

BLANK = [ EmptyTrue.new, nil, false, '', '   ', "  \n\t  \r ", '　', [], {} ]
NOT   = [ EmptyFalse.new, Object.new, true, 0, 1, 'a', [nil], { nil => 0 } ]

describe "blank" do
  describe "blank?" do
    BLANK.each do |v|
      it "should treat #{v.inspect} as blank" do
        v.should.be.blank
      end
    end
    
    NOT.each do |v|
      it "should treat #{v.inspect} as NOT blank" do
        v.should.not.be.blank
      end
    end
  end

  describe "present?" do
    BLANK.each do |v|
      it "should treat #{v.inspect} as NOT present" do
        v.should.not.be.present
      end
    end
    
    NOT.each do |v|
      it "should treat #{v.inspect} as present" do
        v.should.be.present
      end
    end
  end

  describe "presence" do
    BLANK.each do |v|
      it "should return nil for #{v.inspect}.presence" do
        v.presence.should.be.nil
      end
    end
    
    NOT.each do |v|
      it "should return self for #{v.inspect}.presence" do
        v.presence.should == v
      end
    end
  end
end
