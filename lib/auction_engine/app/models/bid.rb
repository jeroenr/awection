require 'time'

class Bid
  attr_accessor :user, :amount, :timestamp

  def initialize(user, amount, timestamp = Time.now.getutc)
    @user = user
    @amount = amount.to_f
    @timestamp = timestamp
  end

  def self.deserialize(serialized_bid)
    user = serialized_bid[:user]
    amount = serialized_bid[:amount]
    timestamp_string = serialized_bid[:timestamp]
    timestamp = Time.parse(timestamp_string)
    Bid.new(user, amount, timestamp)
  end

  def serialize
    {
        :user => @user,
        :amount => @amount.to_s,
        :timestamp => @timestamp.to_s
    }
  end

  def >=(bid)
    amount > bid.amount || (amount == bid.amount and timestamp < bid.timestamp)
  end
end