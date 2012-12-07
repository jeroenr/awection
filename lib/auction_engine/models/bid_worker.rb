class BidWorker
      
  def initialize
    @bid_queue = BidQueue.new
    @top_bids = TopBids.new
  end
  
  def do_loop
    while take_bid
      process
    end
  end  
  
  def take_bid
    @fresh_bid_hash = @bid_queue.take_bid
    if @fresh_bid_hash.to_s.strip.empty?
      return false
    else
      @fresh_bid_hash = eval(@fresh_bid_hash) if @fresh_bid_hash
      return true
    end
  end
  
  def process
    
    $mutex.synchronize do   
            
      # compare to highest bid
      top_bid = @top_bids.top_bid
      if top_bid && (@fresh_bid_hash[:amount] <= eval(top_bid)[:amount])
        return false
      end
                  
      # insert at top of of bid cache
      @top_bids.insert(@fresh_bid_hash)
      
      #cleanup
      
    end
  end
  
  def cleanup
    @fresh_bid_hash = nil
  end
  
end