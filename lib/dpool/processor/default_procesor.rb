require_relative '../../../lib/dpool/dispatcher/default_dispatcher'
module DPool

  class DefaultProcessor
    def self.enqueue(&task)
      DefaultDispatcher.process(&task) if block_given?
    end
  end

end
