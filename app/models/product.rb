class Product < ActiveRecord::Base
  belongs_to :supplier
  has_many :images

  has_many :categorized_products
  has_many :categories, through: :categorized_products

  has_many :carted_products
  has_many :orders, through: :carted_products

  validates :name, presence: true, length: { minimum: 2 }
  validates :price, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :description, presence: true
  validates :name, uniqueness: true 

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
