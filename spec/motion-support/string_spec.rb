describe "string" do
  describe "pluralize" do
    it "should return self if string is already plural" do
      "houses".pluralize.should == "houses"
      "trains".pluralize.should == "trains"
    end
    
    it "should return plural version for singular string" do
      "house".pluralize.should == "houses"
      "train".pluralize.should == "trains"
    end
  end
  
  describe "singularize" do
    it "should return self if string is already singular" do
      "house".singularize.should == "house"
      "train".singularize.should == "train"
    end
    
    it "should return singular version for plural string" do
      "houses".singularize.should == "house"
      "trains".singularize.should == "train"
    end
  end
  
  describe "classify" do
    it "should return classified string for underscored singular string" do
      "search_controller".classify.should == "SearchController"
    end
    
    it "should return classified string for underscored plural string" do
      "search_controllers".classify.should == "SearchController"
    end
    
    it "should return classified string for camelized singular string" do
      "SearchController".classify.should == "SearchController"
    end
    
    it "should return classified string for camelized plural string" do
      "SearchControllers".classify.should == "SearchController"
    end
  end
end
