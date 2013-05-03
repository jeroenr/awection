class BidQueue < RedisEntity
  QUEUE_NAME = "bid_queue"

  def size
    @db.llen(QUEUE_NAME)
  end

  def add_bid(bid)
    @db.lpush(QUEUE_NAME, bid.serialize)
    @db.publish(QUEUE_NAME, bid.serialize)
  end

  def take_bid
    bid = @db.lpop(QUEUE_NAME)

    Bid.deserialize(bid) if bid
  end
end
