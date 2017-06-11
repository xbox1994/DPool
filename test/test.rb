require_relative '../lib/dpool/definable_pool'
require_relative '../lib/dpool/dispatcher/default_dispatcher'

DPool::DefinablePool.rock(5)

pool = DPool::DefinablePool.getPool

pool.post do
  loop{
    sleep 1
    p "ahahah"
  }
end
pool.post do
  loop{
    sleep 1
    p "ahahah"
  }
end
pool.post do
  loop{
    sleep 1
    p "ahahah"
  }
end
pool.post do

    sleep 1
    p "ahahah"
end

loop{
  sleep 1
  p DPool::DefinablePool.getPool
p DPool::DefinablePool.getPool.scheduled_task_count
}
