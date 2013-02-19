class BidWorker

  def self.mutex
    # rubys built in mutex runs *much* faster than a network mutex so needs to be globally available across all threads
    @mutex ||= Mutex.new
  end

  def initialize
    @bid_queue = BidQueue.new
    @top_bids = TopBids.new
    @top_bids_channel = TopBidsChannel.new
  end
  
  def do_loop
    loop do
      latest_bid = @bid_queue.take_bid
      process(latest_bid) if latest_bid
      sleep 1
    end
  end

  def handle_new_top_bid(top_bid)
    # insert at top of of bid cache
    @top_bids.insert(top_bid)

    # Push highest bid
    puts "highest bid is going to be pushed #{top_bid}"
    @top_bids_channel.new_top_bid top_bid
  end
  
  def process(latest_bid)
    
    self.class.mutex.synchronize do
      # compare to highest bid
      top_bid = @top_bids.top_bid
      puts "processing... #{top_bid}"
      if top_bid and (latest_bid[:amount].to_f <= top_bid[:amount].to_f)
        return false
      end
      handle_new_top_bid(latest_bid)
    end
  end
end
