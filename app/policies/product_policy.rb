class ProductPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
  # Setting to true allows the user to view the product, false denies access
  def index?
    true
  end


  # User can edit the product if they are the owner of the product
  def edit?
    # user.admin? || current_user.products.find(params[:id])
    # user.id == record.product.user_id
    user.id == record.user_id
  end


  # User can update the product if they are the owner of the product
  def update?
    edit?
  end

  # User can delete the product if they are the owner of the product
  def destroy?
    edit?
  end

  private
  def user_is_owner?
    user.id == record.user_id
  end
  
end
