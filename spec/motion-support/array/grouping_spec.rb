describe 'array grouping' do
  describe "in_groups_of" do
    it "should group array and fill rest with nil" do
      %w(1 2 3 4 5 6 7 8 9 10).in_groups_of(3).should == [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"],
        ["10", nil, nil]
      ]
    end
    
    it "should group array and fill with specified filler" do
      %w(1 2 3 4 5).in_groups_of(2, 'empty').should == [
        ["1", "2"],
        ["3", "4"],
        ["5", "empty"]
      ]
    end
    
    it "should not fill the last group if turned off" do
      %w(1 2 3 4 5).in_groups_of(2, false).should == [
        ["1", "2"],
        ["3", "4"],
        ["5"]
      ]
    end
    
    it "should yield each slice to a block if given" do
      result = []
      %w(1 2 3 4 5 6 7 8 9 10).in_groups_of(3) { |group| result << ['foo'] + group + ['bar'] }
      result.should == [
        ["foo", "1", "2", "3", "bar"],
        ["foo", "4", "5", "6", "bar"],
        ["foo", "7", "8", "9", "bar"],
        ["foo", "10", nil, nil, "bar"]
      ]
    end
  end
  
  describe "in_groups" do
    it "should group array and fill the rest with nil" do
      %w(1 2 3 4 5 6 7 8 9 10).in_groups(3).should == [
        ["1", "2", "3", "4"],
        ["5", "6", "7", nil],
        ["8", "9", "10", nil]
      ]
    end
    
    it "should group array and fill the result with specified filler" do
      %w(1 2 3 4 5 6 7 8 9 10).in_groups(3, 'empty').should == [
        ["1", "2", "3", "4"],
        ["5", "6", "7", "empty"],
        ["8", "9", "10", "empty"]
      ]
    end
    
    it "should not fill the last group if turned off" do
      %w(1 2 3 4 5 6 7).in_groups(3, false).should == [
        ["1", "2", "3"],
        ["4", "5"],
        ["6", "7"]
      ]
    end
    
    it "should yield each slice to a block if given" do
      result = []
      %w(1 2 3 4 5 6 7 8 9 10).in_groups(3) { |group| result << ['foo'] + group + ['bar'] }
      result.should == [
        ["foo", "1", "2", "3", "4", "bar"],
        ["foo", "5", "6", "7", nil, "bar"],
        ["foo", "8", "9", "10", nil, "bar"]
      ]
    end
  end
  
  describe "split" do
    it "should split array based on delimiting value" do
      [1, 2, 3, 4, 5].split(3).should == [[1, 2], [4, 5]]
    end
    
    it "should split array based on block result" do
      (1..10).to_a.split { |i| i % 3 == 0 }.should == [[1, 2], [4, 5], [7, 8], [10]]
    end
  end
end
