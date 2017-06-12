require_relative '../../../lib/dpool/pool/request_limit_pool'
module DPool

  class RequestLimitProcessor
    attr_reader :taskBuffer
    attr_reader :result

    def initialize
      @taskBuffer = []
      @result = []
      RequestLimitPool.addRequest(self)
    end

    def enqueue(&task)
      raise ArgumentError.new('no block given') unless block_given?
      @taskBuffer << task
    end

    def finished?
      while !@finished
        sleep 1
      end
      true
    end

    def setFinished
      @finished = true
    end
    
    def addToResult(object)
      @result << object
    end
  end

end