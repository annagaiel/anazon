class Supplier < ActiveRecord::Base
  has_many :products

  validates :name, :email, :phone_number, presence: true
end
