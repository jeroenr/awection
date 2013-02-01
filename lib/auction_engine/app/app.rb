
require 'bundler/setup'

require 'sinatra/base'
require 'erb'
require 'benchmark'
require 'thread'

require 'redis'

require 'coffee_script'

require 'sinatra/assetpack'

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
    set :root, File.dirname(__FILE__)
    set :views, File.dirname(__FILE__) + '/views'

    register Sinatra::AssetPack

    assets {
        serve '/js',     from: 'assets/js'        # Optional
        serve '/css',    from: 'assets/css'       # Optional
        serve '/images', from: 'assets/images'    # Optional

        # The second parameter defines where the compressed version will be served.
        # (Note: that parameter is optional, AssetPack will figure it out.)
        js :application, '/js/application.js', [
          '/js/vendor/jquery*.js',
          '/js/vendor/underscore-min.js',
          '/js/vendor/*.js',
          '/js/app/*.js'

        ]

        css :application, '/css/application.css', [
          '/css/main.css'
        ]

        prebuild ENV['RACK_ENV'] == 'production'
      }
    

    
    get "/" do
      erb :index
    end

    post "/bids" do
      bid = request.body.read
      $bid_queue.add_bid(
                  {
                      :user => bid['user'],
                      :amount => bid['amount']
                  })
      ""
    end

    # Ugly way to run BidWorker pool as a daemon
    (1..10).each do |t|
      Thread.new do
        BidWorker.new.do_loop
      end
    end
  end
end
