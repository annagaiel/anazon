class CartedProduct < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  validates :quantity_must_be_less_than_5

  def quantity_must_be_less_than_5
    if quantity && quantity > 4
      errors.add(:quantity, "You can only have up to 4 products")
    end
  end
end
