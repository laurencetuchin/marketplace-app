class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  # Get popular line items based on quantity descending with product id
  def self.popular
    order(quantity: :desc).limit(5)
  end

  # Get total price of all items in cart
  def total_price
    product.price.to_i * quantity.to_i
  end


end
