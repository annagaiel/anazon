class Product < ActiveRecord::Base
  validates :name, presence: true
  validates :price, presence: true
  validates :image, presence: true
  validates :description, presence: true

  DISCOUNT_THRESHOLD = 2

  def sale_message
    price < DISCOUNT_THRESHOLD ? "Discount Item" : "On Sale!"
  end

  def tax
    price * 0.09
  end

  def total
    price + tax
  end

  def color_price
    price < DISCOUNT_THRESHOLD ? "green" : "red"
  end
end
