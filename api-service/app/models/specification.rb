class Specification < ApplicationRecord
  has_many :product_specifications
  has_many :products, through: :product_specifications
end
