require 'time'

class Bid
  attr_accessor :user, :amount, :timestamp

  def initialize(user, amount, timestamp = Time.now.getutc)
    @user      = user
    @amount    = amount.to_i
    @timestamp = timestamp
  end

  def self.deserialize(serialized_bid)
    serialized_bid = JSON.parse(serialized_bid, symbolize_names: true)

    user      = serialized_bid[:user]
    amount    = serialized_bid[:amount]
    timestamp = Time.parse(serialized_bid[:timestamp])

    Bid.new(user, amount, timestamp)
  end

  def serialize
    { user: @user, amount: @amount.to_s, timestamp: @timestamp.to_s }.to_json
  end

  def >=(bid)
    amount > bid.amount || (amount == bid.amount && timestamp < bid.timestamp)
  end
end
