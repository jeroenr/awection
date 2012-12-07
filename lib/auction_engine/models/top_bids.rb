class TopBids
  LIST_NAME = "top_bids_cache"
  
  def initialize
    @db = Redis.new(:host => 'localhost', :port => 6379)
  end
  
  def size
    @db.llen(LIST_NAME)
  end
  
  def top_bid
    @db.lindex(LIST_NAME, 0)
  end
  
  def insert(hash)
    @db.lpush(LIST_NAME, hash)
    @db.ltrim(LIST_NAME,0, 4)
  end
  
  def dump
    @db.lrange(LIST_NAME, 0, 10)
  end
  
end