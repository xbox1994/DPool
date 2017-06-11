require_relative '../lib/dpool/pool/default_pool'
require_relative '../lib/dpool/dispatcher/request_limit_dispatcher'
require_relative '../lib/dpool/processor/request_limit_processor'

#install pool and specific processor's limit
DPool::DefinablePool.rock(15)
DPool::RequestLimitProcessor.setSingleRequestMaxThreadCount(4)

processor = DPool::RequestLimitProcessor.new

(1..15).each do |i|
  processor.enqueue do
    puts "task #{i}: request costs 3s has been send"
    sleep 3
    puts "task #{i}: done"
  end
end

p processor.getResults if processor.allFinished?