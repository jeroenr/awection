APP_ROOT = File.expand_path(File.join(File.dirname(__FILE__), "../../"))

require 'sinatra/base'
require 'erb'
require 'benchmark'
require 'thread'

require 'redis'

require File.join(File.dirname(__FILE__), 'models/bid_queue')
require File.join(File.dirname(__FILE__), 'models/bid_worker')
require File.join(File.dirname(__FILE__), 'models/top_bids')


# globally available across all threads for stats
$redis = Redis.new(:host => 'localhost', :port => 6379)
$bid_queue = BidQueue.new
$top_bids = TopBids.new
# rubys built in mutex runs *much* faster than a network mutex so needs to be globally available across all threads
$mutex = Mutex.new

module AuctionEngine
  class App < Sinatra::Base
    
    set :views, File.dirname(__FILE__) + '/views'
    
    
    get "/" do
      "Size: "+$bid_queue.size.to_s
    end
    
    get "/strap" do
      $redis.flushdb
      (1..100000).to_a.reverse.each do |i|
        $bid_queue.add_bid(
            {
                :user => "user #{i}",
                :amount => rand(9999) + 1
            })
      end
      "Bid Queue Size: "+$bid_queue.size.to_s
    end
    
    get "/stats" do
      erb :stats
    end
    
    get "/current_stats" do
      str = ""
      str+= "Time now: "+Time.now.to_s+"<br />"
      str+= "Queue size: "+$bid_queue.size.to_s+"<br />"
      str+= "Top Bid: "+$top_bids.top_bid.inspect+"<br />"
      str
    end
    
    get "/process" do
      (1..10).each do |t|
        Thread.new do
          BidWorker.new.do_loop
        end
      end
      ""
    end


  end
end
