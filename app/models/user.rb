class User < ApplicationRecord
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :products, dependent: :destroy
  has_one :cart
  # Create a role for the user which each user can be both a buyer and a seller or both.
  # enum role: [:buyer, :seller]
  # after_initialize :set_default_role, :if => :new_record?

  # def set_default_role
  #   self.role ||= :buyer
  # end

  def alias
    return self.email.split('@')[0].capitalize
  end

  # Validates extra fields that arent preconfigured in devise.
  validates :name, presence: true, length: { maximum: 50 }
  validates :address, presence: true, length: { maximum: 250 }
  validates :username, presence: true, uniqueness: true, length: { minimum: 2 } 
  validates :location, presence: true, length: { minimum: 2 }

  
end
