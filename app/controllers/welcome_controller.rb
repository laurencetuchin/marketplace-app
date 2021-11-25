class WelcomeController < ApplicationController
    def index 
        @products = Product.all

        # Show last 5 products added to database
      
        @last_products = Product.order(created_at: :desc).limit(5)
            
        
    end

 

end
