class RedisEntity
  def initialize
    @db = Redis.new(:host => 'localhost', :port => 6379)
  end

  def from_raw(raw_data)
    eval(raw_data) if raw_data
  end

  def flush
  	@db.flushall
  end
end