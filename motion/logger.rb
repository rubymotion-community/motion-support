module Kernel
  def log(*args)
    MotionSupport.logger.log(*args)
  end
  
  def l(*args)
    MotionSupport.logger.log(args.map { |a| a.inspect })
  end
end

module MotionSupport
  class NullLogger
    def log(*args)
    end
  end

  class StdoutLogger
    def log(*args)
      puts args
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
    
    def log(*args)
      args.each do |string|
        data = NSData.alloc.initWithData("#{string}\n".dataUsingEncoding(NSASCIIStringEncoding))
        @output_stream.write(data.bytes, maxLength:data.length)
      end
    end
  end
  
  mattr_writer :logger
  
  def self.logger
    @logger ||= StdoutLogger.new
  end
end
