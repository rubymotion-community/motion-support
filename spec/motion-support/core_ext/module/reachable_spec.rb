describe "Module" do
  describe "reachable?" do
    it "should be false for an anonymous module" do
      Module.new.should.not.be.reachable
    end
    
    it "should be false for an anonymous class" do
      Class.new.should.not.be.reachable
    end

    it "should be true for a named module" do
      Kernel.should.be.reachable
    end
    
    it "should be true for a named class" do
      Object.should.be.reachable
    end

    it "should be false for a named class whose constant has gone" do
      class C; end
      c = C

      Object.send(:remove_const, :C)

      c.should.not.be.reachable
    end

    it "should be false for a named module whose constant has gone" do
      module M; end
      m = M
    
      Object.send(:remove_const, :M)
    
      m.should.not.be.reachable
    end
    
    it "should be false for a named class whose constant was redefined" do
      class C; end
      c = C
    
      Object.send(:remove_const, :C)
    
      class C; end
    
      C.should.be.reachable
      c.should.not.be.reachable
    end
    
    it "should be false for a named module whose constant was redefined" do
      module M; end
      m = M
    
      Object.send(:remove_const, :M)
    
      module M; end
    
      M.should.be.reachable
      m.should.not.be.reachable
    end
  end
end
