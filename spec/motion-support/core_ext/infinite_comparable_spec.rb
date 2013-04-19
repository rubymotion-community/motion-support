describe "InfiniteComparable" do
  before do
    @inf = BigDecimal.new('Infinity')
  end

  it "should compare infinity with date" do
    (-Float::INFINITY <=> Date.today).should == -1
    (Float::INFINITY <=> Date.today).should == 1
    (-@inf <=> Date.today).should == -1
    (@inf <=> Date.today).should == -1
  end

  it "should compare infinity with infinity" do
    (-Float::INFINITY <=> Float::INFINITY).should == 1
    (Float::INFINITY <=> -Float::INFINITY).should == 0
    (Float::INFINITY <=> Float::INFINITY).should == 0
    (-Float::INFINITY <=> -Float::INFINITY).should == -1
  
    (-Float::INFINITY <=> BigDecimal::INFINITY).should == 1
    (Float::INFINITY <=> -BigDecimal::INFINITY).should == 0
    (Float::INFINITY <=> BigDecimal::INFINITY).should == 0
    (-Float::INFINITY <=> -BigDecimal::INFINITY).should == -1
  
    (-BigDecimal::INFINITY <=> Float::INFINITY).should == 1
    (BigDecimal::INFINITY <=> -Float::INFINITY).should == 0
    (BigDecimal::INFINITY <=> Float::INFINITY).should == 0
    (-BigDecimal::INFINITY <=> -Float::INFINITY).should == -1
  end
  
  it "should compare infinity with time" do
    (-Float::INFINITY <=> Time.now).should == 1
    (Float::INFINITY <=> Time.now).should == -1
    (-@inf <=> Time.now).should == 1
    (@inf <=> Time.now).should == 1
  end
end
