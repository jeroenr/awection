require 'bundler/setup'
require 'sinatra/base'
require 'json'
require 'erb'
require 'benchmark'
require 'thread'

require 'redis'

require 'coffee_script'

require 'thin'

require 'sinatra/assetpack'
require 'sinatra/reloader'

require File.join(File.dirname(__FILE__), 'models/redis_entity')
require File.join(File.dirname(__FILE__), 'models/bid')
require File.join(File.dirname(__FILE__), 'models/bid_queue')
require File.join(File.dirname(__FILE__), 'models/bid_worker')
require File.join(File.dirname(__FILE__), 'models/top_bids')
require File.join(File.dirname(__FILE__), 'models/top_bids_channel')

# globally available across all threads for stats
$bid_queue = BidQueue.new
$top_bids_channel = TopBidsChannel.new

module AuctionEngine
    class App < Sinatra::Base


      set :root, File.dirname(__FILE__)
      set :views, File.dirname(__FILE__) + '/views'

      configure do
        register Sinatra::AssetPack
        register Sinatra::Reloader
      end

      assets {
        serve '/js',  from: 'assets/js'
        serve '/css', from: 'assets/css'
        serve '/img', from: 'assets/img'
        serve 'font', from: 'assets/font'

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
        bid = JSON.parse(request.body.read)
        $bid_queue.add_bid(Bid.new(bid['user'], bid['amount']))
        ""
      end
    end

    # Ugly way to run BidWorker pool as a daemon
    (1..10).each do |t|
      Thread.new do
        BidWorker.new.do_loop
      end

    end

    App.run!({:port => 3000})
  end
