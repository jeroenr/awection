class BidQueue < RedisEntity
  QUEUE_NAME = "bid_queue"

  def size
    @db.llen(QUEUE_NAME)
  end

  def add_bid(bid)
    @db.lpush(QUEUE_NAME, bid.serialize)
    @db.publish(QUEUE_NAME, bid.serialize.to_json)
  end

  def take_bid
    h = from_raw(@db.lpop(QUEUE_NAME))
    Bid.deserialize(h) if h
  end

end
