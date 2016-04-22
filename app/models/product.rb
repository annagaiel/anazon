class Product < ActiveRecord::Base
  validates :name, presence: true
  validates :price, presence: true
  validates :image, presence: true
  validates :description, presence: true

  DISCOUNT_THRESHOLD = 2
  QUANTITY = 0

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

  def self.in_stock
    QUANTITY > 5 ? true :false
  end

  def self.random
    all_products = Product.all
    valid_ids = []
    all_products.each do |product|
      valid_ids << product.id
    end
    valid_ids.sample
  end
end
