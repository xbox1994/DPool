require 'concurrent'
module DPool

  class RequestLimitPool

    def self.rock(thread_limit_count, single_request_max_thread_count)
      @@thread_limit_count = thread_limit_count
      @@single_request_max_thread_count = single_request_max_thread_count
      @@bufferQueue = []
      @@threadCount = 0
      raise ArgumentError.new('please setSingleRequestMaxThreadCount first') if @@single_request_max_thread_count.nil? || @@single_request_max_thread_count == 0

      Thread.new {
        loop do
          sleep 0.5
          p @@threadCount
          next if @@threadCount >= @@thread_limit_count || !@@bufferQueue[0]
          current_object = @@bufferQueue.pop
          Thread.new {
            threadBuffer_current = current_object.taskBuffer
            while threadBuffer_current.size > 0 do
              threadArray = []
              thread_count = [threadBuffer_current.size, @@single_request_max_thread_count, @@thread_limit_count - @@threadCount].min
              thread_count.times {
                threadArray << Thread.new {
                  @@threadCount += 1
                  current_object.addToResult(threadBuffer_current.pop.call)
                }
              }
              threadArray.each {|thread| thread.join}
              @@threadCount -= thread_count
            end
            current_object.setFinished
          }
        end
      }
    end

    def self.addRequest(request)
      @@bufferQueue << request
    end
  end

end