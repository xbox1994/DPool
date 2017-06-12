require_relative '../lib/dpool/pool/request_limit_pool'
require_relative '../lib/dpool/processor/request_limit_processor'

#install pool and specific processor's limit
DPool::RequestLimitPool.rock(15, 4)

processorList = []

(1..3).each do |j|
  processor = DPool::RequestLimitProcessor.new

  processorList << processor

  (1..5).each do |i|
    processor.enqueue do
      p "task #{i}: request costs 3s has been send"
      sleep 3
      p "task #{i}: done"
      {result: i}
    end
  end
end

processorList.each do |processor|
  p processor.result if processor.finished?
end
