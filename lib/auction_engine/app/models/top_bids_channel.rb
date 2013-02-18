class TopBidsChannel < RedisEntity
  CHANNEL_NAME = "top_bids_channel"

  def on_top_bid(&block)
    @db.subscribe(CHANNEL_NAME, &block)
  end

  def new_top_bid(message)
    @db.publish(CHANNEL_NAME, message)
  end
end