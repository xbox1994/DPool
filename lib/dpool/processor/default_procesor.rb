module DPool

  class DefaultProcessor
    def self.enqueue(&task)
      raise ArgumentError.new('no block given') unless block_given?

      DPool::DefaultPool.getPool.post &task
    end
  end

end
