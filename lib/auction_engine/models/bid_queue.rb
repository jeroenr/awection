class BidQueue
  QUEUE_NAME = "bid_queue"
  
  def initialize
    @db = Redis.new(:host => 'localhost', :port => 6379)
  end
  
  def size
    @db.llen(QUEUE_NAME)
  end
  
  def add_bid(hash)
    @db.lpush(QUEUE_NAME, hash)
  end
  
  def take_bid
    @db.lpop(QUEUE_NAME)
  end
  
end