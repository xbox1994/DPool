require_relative '../lib/dpool/definable_pool'
require_relative '../lib/dpool/dispatcher/default_dispatcher'
require_relative '../lib/dpool/processor/default_procesor'

#install pool
DPool::DefinablePool.rock(3)

DPool::DefaultProcessor.enqueue do
  loop{
    sleep 1
    p 'forever task 1'
  }
end

DPool::DefaultProcessor.enqueue do
  loop{
    sleep 1
    p 'forever task 2'
  }
end

DPool::DefaultProcessor.enqueue do
    sleep 1
    p 'temp task 3'
end

DPool::DefaultProcessor.enqueue do
  loop{
    sleep 1
    p 'new forever task 4'
  }
end

loop{
  sleep 1
}