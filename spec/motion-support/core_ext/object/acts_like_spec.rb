class DuckFoo
  def acts_like_foo?
    true
  end
end

describe "Object" do
  describe "acts_like" do
    it "should not act like anything" do
      object = Object.new
      object.should.not.acts_like(:time)
      object.should.not.acts_like(:date)
      object.should.not.acts_like(:foo)
    end
    
    it "should allow subclasses to act like something" do
      object = DuckFoo.new
      object.should.acts_like(:foo)
    end
  end
end
