require_relative '../lib/dpool/pool/default_pool'
require_relative '../lib/dpool/processor/default_procesor'

#install pool
DPool::DefaultPool.rock(3)

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