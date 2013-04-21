class Should
  def equal_query(query)
    @object.to_query.split('&').should == query.split('&')
  end
end

describe "to_query" do
  it "should do a simple converion" do
    { :a => 10 }.should.equal_query 'a=10'
  end

  it "should escape for CGI" do
    { 'a:b' => 'c d' }.should.equal_query 'a%3Ab=c+d'
  end
  
  it "should work with nil parameter value" do
    empty = Object.new
    def empty.to_param; nil end
    { 'a' => empty }.should.equal_query 'a='
  end
  
  it "should do a nested conversion" do
    { :person => Hash[:login, 'seckar', :name, 'Nicholas'] }.should.equal_query 'person%5Blogin%5D=seckar&person%5Bname%5D=Nicholas'
  end
  
  it "should do a multiply nested query" do
    Hash[:account, {:person => {:id => 20}}, :person, {:id => 10}].should.equal_query 'account%5Bperson%5D%5Bid%5D=20&person%5Bid%5D=10'
  end
  
  it "should work with array values" do
    { :person => {:id => [10, 20]} }.should.equal_query 'person%5Bid%5D%5B%5D=10&person%5Bid%5D%5B%5D=20'
  end
  
  it "should not sort array values" do
    { :person => {:id => [20, 10]} }.should.equal_query 'person%5Bid%5D%5B%5D=20&person%5Bid%5D%5B%5D=10'
  end
end
