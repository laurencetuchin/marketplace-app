class ApplicationController < ActionController::Base
    include CurrentCart
    include Pundit
    before_action :authenticate_user!, except: [:welcome]
    before_action :set_cart
    protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :username, :location, :address, :city, :admin])
        devise_parameter_sanitizer.permit(:account_update, keys: [:name, :username, :location, :address, :city, :admin])
    end



    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private
    
    def user_not_authorized
        flash[:alert] = "You are not authorized to perform this action."
        redirect_to(request.referrer || root_path)
    end

end

