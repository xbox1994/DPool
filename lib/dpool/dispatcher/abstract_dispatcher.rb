module DPool

  class AbstractDispatcher
    def self.process(&task)
      raise Concurrent::NotImplementedError
    end

    def process(&task)
      raise Concurrent::NotImplementedError
    end
  end

end
