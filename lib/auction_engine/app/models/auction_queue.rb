class AuctionQueue < RedisEntity
  QUEUE_NAME = "auction"

  def start
    @db.flushall
    @db.publish(QUEUE_NAME, "start")
  end

end
