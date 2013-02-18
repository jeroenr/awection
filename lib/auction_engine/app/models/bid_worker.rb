class BidWorker
      
  def initialize
    @bid_queue = BidQueue.new
    @top_bids = TopBids.new
    @top_bids_channel = TopBidsChannel.new
  end
  
  def do_loop
    while true
      latest_bid = @bid_queue.take_bid
      process(latest_bid) if latest_bid
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
    
    $mutex.synchronize do   
      # compare to highest bid
      top_bid = @top_bids.top_bid
      puts "processing... #{top_bid}"
      if top_bid && latest_bid[:amount] > top_bid[:amount]
        handle_new_top_bid(latest_bid)
      else
        return false
      end
    end
  end

end