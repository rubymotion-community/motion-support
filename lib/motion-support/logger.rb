module MotionSupport
  class NullLogger
    def log(string)
    end
  end

  class StdoutLogger
    def log(string)
      puts string
    end
  end
  
  class NetworkLogger
    def initialize(host = "localhost", port = 2000)
      readStream = Pointer.new(:object)
      writeStream = Pointer.new(:object)
      CFStreamCreatePairWithSocketToHost(nil, host, port, readStream, writeStream)
      @output_stream = writeStream[0]
      @output_stream.setDelegate(self)
      @output_stream.scheduleInRunLoop(NSRunLoop.currentRunLoop, forMode:NSDefaultRunLoopMode)
      @output_stream.open
    end
    
    def log(string)
      data = NSData.alloc.initWithData("#{string}\n".dataUsingEncoding(NSASCIIStringEncoding))
      @output_stream.write(data.bytes, maxLength:data.length);
    end
  end
end
