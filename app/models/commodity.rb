class Commodity < ActiveRecord::Base
  attr_accessor :current_location, :destination, :distance, :max, :min
  has_many :cart_items
  has_many :carts, :through => :cart_items
  validates :commname,  presence: true, length: { maximum: 50 }
  validates :price,  presence: true, numericality: { only_float: true }
  validates :quantity,  presence: true, numericality: { only_integer: true } 
end
