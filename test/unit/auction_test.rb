require 'test_helper'

class AuctionTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Auction.new.valid?
  end
end
