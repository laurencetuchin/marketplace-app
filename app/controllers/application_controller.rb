class ApplicationController < ActionController::Base
    include CurrentCart
    before_action :authenticate_user!, except: [:welcome]
    before_action :set_cart
    protect_from_forgery with: :exception


end

