require_relative '../../../lib/dpool/dispatcher/request_limit_dispatcher'
module DPool

  class RequestLimitProcessor

    def self.setSingleRequestMaxThreadCount(single_request_max_thread_count)
      @@single_request_max_thread_count = single_request_max_thread_count
    end

    def initialize
      p 'please setSingleRequestMaxThreadCount first' if @@single_request_max_thread_count.nil? || @@single_request_max_thread_count == 0
      @taskBuffer = []


    end

    def enqueue(&task)
      if !block_given?
        raise Exception.new('please give me a task block')
        return
      end

      @taskBuffer << task
    end

    def allFinished?

    end

    def getResults

    end

  end

end