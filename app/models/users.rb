class Users < ActiveRecord::Base
  belong_to :users
  belong_to :auctions
end

