class Product < ActiveRecord::Base
  belongs_to :supplier
  has_many :images
  has_many :orders
  has_many :categorized_products
  has_many :categories, through: :categorized_products

  validates :name, presence: true
  validates :price, presence: true
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
    price < DISCOUNT_THRESHOLD ? "available-price" : "sale-price"
  end

  def self.in_stock
    QUANTITY > 5 ? true :false
  end
end
