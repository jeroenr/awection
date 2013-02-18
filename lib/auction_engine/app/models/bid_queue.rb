class BidQueue < RedisEntity
  QUEUE_NAME = "bid_queue"
  
  def size
    @db.llen(QUEUE_NAME)
  end
  
  def add_bid(hash)
    @db.lpush(QUEUE_NAME, hash)
  end
  
  def take_bid
    from_raw(@db.lpop(QUEUE_NAME))
  end
  
end