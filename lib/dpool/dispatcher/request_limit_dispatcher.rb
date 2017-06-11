require_relative '../definable_pool'
require_relative '../dispatcher/abstract_dispatcher'
module DPool

  class RequestLimitDispatcher < AbstractDispatcher
    @@running_thread = Concurrent::AtomicFixnum.new(0)

    def initialize(single_request_max_thread_count)
      @single_request_max_thread_count = single_request_max_thread_count
      @task_buffer = []

      Thread.new{

      }
    end

    def process(&task)
      if !block_given?
        raise Exception.new('please give a task block')
        return
      end

      begin
        @task_buffer << task
        DPool::DefinablePool.getPool.post &task if available_thread?
      rescue
      end
    end

    private

    def available_thread?

    end
  end
end