class Payments < ApplicationRecord
# Let a user pay for their products in checkout
    belongs_to :user
    belongs_to :order
    validates :amount, presence: true
    validates :amount, numericality: { greater_than: 0 }
    validates :user_id, presence: true
    validates :order_id, presence: true


end