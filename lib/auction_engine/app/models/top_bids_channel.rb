class TopBidsChannel < RedisEntity
  CHANNEL_NAME = "top_bids_channel"

  def on_top_bid(&block)
    @db.subscribe(CHANNEL_NAME, &block)
  end

  def new_top_bid(bid)
    @db.publish(CHANNEL_NAME, bid.serialize.to_json)
  end
end