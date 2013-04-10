describe "Numeric" do
  describe "bytes" do
    it "should calculate kilobytes" do
      1.kilobyte.should == 1024.bytes
      3.kilobytes.should == 3072
      3.kilobyte.should == 3072
    end
    
    it "should calculate megabytes" do
      1.megabyte.should == 1024.kilobytes
      3.5.megabytes.should == 3584.0.kilobytes
      3.megabytes.should == 1024.kilobytes + 2.megabytes
      512.megabytes.should == 2.gigabytes / 4
      3.megabytes.should == 3145728
      3.megabyte.should == 3145728
    end
    
    it "should calculate gigabytes" do
      3.5.gigabytes.should == 3584.0.megabytes
      10.gigabytes.should == 256.megabytes * 20 + 5.gigabytes
      3.gigabytes.should == 3221225472
      3.gigabyte.should == 3221225472
    end
    
    it "should calculate terabytes" do
      1.terabyte.should == 1.kilobyte ** 4
      3.terabytes.should == 3298534883328
      3.terabyte.should == 3298534883328
    end
    
    it "should calculate petabytes" do
      1.petabyte.should == 1.kilobyte ** 5
      3.petabytes.should == 3377699720527872
      3.petabyte.should == 3377699720527872
    end
    
    it "should calculate exabytes" do
      1.exabyte.should == 1.kilobyte ** 6
      3.exabytes.should == 3458764513820540928
      3.exabyte.should == 3458764513820540928
    end
  end
end
