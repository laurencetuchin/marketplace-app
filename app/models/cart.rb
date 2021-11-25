# Create a cart model that lets a user add a product to cart and remove a product from cart
class Cart < ApplicationRecord
    belongs_to :user 
    belongs_to :product
    has_many :line_items, dependent: :destroy

    def add_product(product)
        current_item = line_items.find_by(product_id: product.id)
        if current_item
            current_item.increment(:quantity)
        else
            current_item = line_items.build(product_id: product.id)
        end
        current_item
    end


    # Check removing product from cart works
    
    def remove_product(product_id)
        product = Product.find(product_id)
        if self.products.include?(product)
            self.products.delete(product)
        end
    end

    # def total_price
    #     total = 0
    #     self.products.each do |product|
    #         total += product.price
    #     end
    #     return total
    # end

    def total_price
        line_items.to_a.sum { |item| item.total_price }
    end

    def total_items
        return self.products.length
    end

    def empty_cart
        self.products.clear
    end

    def checkout
        self.products.clear
    end

    def checkout_total
        total = 0
        self.products.each do |product|
            total += product.price
        end
        return total
    end

    def checkout_items
        return self.products.length
    end


end 