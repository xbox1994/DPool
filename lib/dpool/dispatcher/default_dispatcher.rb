require_relative '../definable_pool'
require_relative '../dispatcher/abstract_dispatcher'
module DPool

  class DefaultDispatcher < AbstractDispatcher

    def self.process(&task)
      DPool::DefinablePool.getPool.post &task if block_given?
    end

  end
end