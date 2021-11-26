class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  # before_action :user_signed_in?
  before_action :authenticate_user!
  rescue_from Pundit::NotAuthorizedError, with: :unauthorised

  # GET /products or /products.json
  def index
    @products = Product.all.order("created_at desc")
    authorize @products
  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = current_user.products.build
  end

  # GET /products/1/edit
  def edit
    authorize @product
  end

  # POST /products or /products.json
  def create
    @product = current_user.products.build(product_params)
    @product.user = current_user
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    product = current_user.products.find(params[:id])
    respond_to do |format|
      if @product.update(product_params)
        authorize @product
        format.html { redirect_to @product, notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy
    authorize @products
    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  # Only allow an authorised user to delete their product
  # def destroy
  #   @product.destroy
  #   if current_user == @product.user
  #     @product.destroy
  #   end
  #   redirect_to products_url, notice: "Product was successfully destroyed."
  # end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Set authorised user to update their product with pundit
    # def set_product
    #   @product = current_user.products.find(params[:id])
    # end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:title, :size, :colour, :location, :condition, :brand, :price, :description, :image, :available, :user_id)
    end
end
