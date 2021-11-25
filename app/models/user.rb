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


  
end
