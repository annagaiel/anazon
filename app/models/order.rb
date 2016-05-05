class Order < ActiveRecord::Base
  belongs_to :user
  has_many :carted_products
  has_many :products, through: :carted_products

  validates :tax, :subtotal, :total, numericality: true, presence: true
end
