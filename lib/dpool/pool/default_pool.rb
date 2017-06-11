require 'concurrent'
module DPool

  class DefinablePool

    def self.rock(working_thread_count)
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