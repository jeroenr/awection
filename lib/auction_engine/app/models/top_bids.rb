class TopBids < RedisEntity
  LIST_NAME = "top_bids_cache"

  def size
    @db.llen(LIST_NAME)
  end

  def top_bid
    top_bid = @db.lindex(LIST_NAME, 0)

    Bid.deserialize(top_bid) if top_bid
  end

  def insert(bid)
    @db.lpush(LIST_NAME, bid.serialize)
    @db.ltrim(LIST_NAME, 0, 10)
  end

  def dump
    @db.lrange(LIST_NAME, 0, 10)
  end
end
