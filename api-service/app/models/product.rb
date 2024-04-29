class Product < ApplicationRecord
  belongs_to :category
  has_many :product_orders, dependent: :destroy
  has_many :orders, through: :product_orders
  has_many :product_specifications, dependent: :destroy
  has_many :specifications, through: :product_specifications
end
