require 'concurrent'
module DPool

  class DefinablePool

    def self.rock(working_thread_count)
      Thread.new {
        loop do

          next if @@threadCount >= THREAD_LIMIT || !@@bufferQueue[0]

          Thread.new {
            arr = @@bufferQueue.pop
            threadBuffer_current = arr[:threadBuffer]
            current_object = arr[:current_object]
            while threadBuffer_current.size > 0 do
              threadArray = []
              thread_count = threadBuffer_current.size < SINGLE_THREAD_LIMIT ? threadBuffer_current.size : SINGLE_THREAD_LIMIT
              thread_count = thread_count < THREAD_LIMIT - @@threadCount ? thread_count : THREAD_LIMIT - @@threadCount
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
      @@pool = Concurrent::ThreadPoolExecutor.new(
          min_threads: 1,
          max_threads: working_thread_count,
          idletime: 60
      )
      @@working_thread_count = working_thread_count
    end

    def self.getPool
      @@pool
    end

    def self.getTotalThreadCountLimit
      @@working_thread_count
    end

    def self.shutdown
      @@pool.shutdown
      @@pool.wait_for_termination
    end
  end

end