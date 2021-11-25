class Product < ApplicationRecord
    has_one_attached :image
    belongs_to :user, optional: true
    has_many :line_items, dependent: :destroy
    before_destroy :ensure_not_referenced_by_any_line_item

    
    # Create link between product and user
    # belongs_to :user 


    # Create DRY product validation
    validates :title, :brand, :price, :description, :image, presence: true

    validates :title, presence: true, length: { minimum: 2 }, :format => { :with => /\A[a-zA-Z0-9\s]+\z/ }
    validates :price, presence: true, :format => { :with => /\A\d+(?:\.\d{0,5})?\z/ }, :numericality => {:greater_than => 0, :less_than => 10000} 
    validates :condition, presence: true, length: { minimum: 2 }
    validates :size, presence: true, length: { minimum: 2 }
    validates :location, presence: true, length: { minimum: 2 }
    validates :brand, presence: true, length: { minimum: 2 }
    validates :description, presence: true, length: { minimum: 10 }  

    # Only a seller can edit or delete a product they own
    # belongs_to :seller, class_name: "User", foreign_key: "user_id"
    # belongs_to :buyer, class_name: "User", foreign_key: "buyer_id"

    # has_many :transactions
    # has_many :users, through: :transactions

    # seller of product can delete their product

    BRAND = %w{ Burton Libtech Rome }
    CONDITION = %w{ New Excellent Good Fair Poor }

    # Show last 5 products added to database
    def self.last_five_products
        Product.order(created_at: :desc).limit(5).each do |product|
            puts product.title
        end
    end

    # Show last 5 products added to database by user
    def self.last_five_products_by_user(user)
        Product.where(user: user).order(created_at: :desc).limit(5)
    end


    # Sort products by price low to high
    scope :price_low_to_high, -> { order(price: :asc) }
    # Sort products by price high to low
    scope :price_high_to_low, -> { order(price: :desc) }
    # Sort products by newest to oldest
    scope :newest_first, -> { order(created_at: :desc) }
    # Sort products by oldest to newest
    scope :oldest_first, -> { order(created_at: :asc) }
    # Sort products by title A-Z
    scope :title_az, -> { order(title: :asc) }
    # Sort products by title Z-A
    scope :title_za, -> { order(title: :desc) }
    # Sort products by brand A-Z
    scope :brand_az, -> { order(brand: :asc) }
    # Sort products by brand Z-A
    scope :brand_za, -> { order(brand: :desc) }
    # Sort products by condition A-Z
    scope :condition_az, -> { order(condition: :asc) }
    # Sort products by condition Z-A
    scope :condition_za, -> { order(condition: :desc) }
    # Sort products by size A-Z
    scope :size_az, -> { order(size: :asc) }
    # Sort products by size Z-A
    scope :size_za, -> { order(size: :desc) }
    # Sort products by location A-Z
    scope :location_az, -> { order(location: :asc) }
    # Sort products by location Z-A
    scope :location_za, -> { order(location: :desc) }
    # Sort products by newest to oldest
    scope :newest_first, -> { order(created_at: :desc) }
    # Sort products by oldest to newest
    scope :oldest_first, -> { order(created_at: :asc) }

    # def self.search(search)
    #     if search

     # Search database for products
     def self.search(search)
        if search
          where(["title ILIKE ? OR description ILIKE ?", "%#{search}%", "%#{search}%"])
        else
          all
        end
      end

       # Find and return products that match search query
    def self.search(query)
        where("title @@ :query OR description @@ :query", query: query)
    end

    # Set product to not available if buyer purchases product
    def self.set_not_available(product_id)
        product = Product.find(product_id)
        product.available = false
        product.save
    end

    
    private

    # Ensure that there are no line items referencing this product
    def ensure_not_referenced_by_any_line_item
        unless line_items.empty?
            errors.add(:base, 'Line Items present')
            throw :abort
        end
    end




end
