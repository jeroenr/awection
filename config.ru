require 'rubygems'

$LOAD_PATH.unshift(::File.expand_path('lib', ::File.dirname(__FILE__)))
require 'rack/coffee'

use Rack::Coffee,
    :urls => '/javascripts'
require 'auction_engine/app'

run AuctionEngine::App