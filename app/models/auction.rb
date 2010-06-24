class Auction < ActiveRecord::Base
  attr_accessible :title, :meta_description, :meta_keywords, :description, :category_id, :start_time, :end_time, :rrp, :start_price, :featured, :delivery_cost, :delivery_information, :peak_only, :fixed_price, :minimum_price, :time_extended, :time_before_extended, :autobid, :autobid_limit, :current_limit, :extend_enabled, :winner_id, :status_id, :closed
end
