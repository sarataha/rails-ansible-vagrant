class ProductsController < ApplicationController
  before_action :check_if_admin,
                only: [:create, :destroy, :update, :edit_status]

  def index
    if logged_in?
      @products = Product.all.order(created_at: :asc)

      # Set search part "Doesn't work to now"
      @search = Product.search(params[:q])
      @products = @search.result
    else
      redirect_to login_path
    end
  end

  # renders the add product page
  def new
    @product = Product.new
  end

  # renders the new product page for a specific product but with the old data being placed
  def edit
    @product = Product.find(params[:id])
    render template: "products/new"
  end

  # create brand new product. POST method
  def create
    @product = {}
    if upload_image
      @product = Product.create(product_params)
      flash[:success] = "#{@product.name} has been added successfully."
      redirect_to dashboard_path
    else
      flash[:error] = "An error occured. Try adding #{@product.name} again."
    end
  end

  # shows only one order with certain id
  def show
    @product = Product.find(params[:id])
  end

  # POST method to update the edited product
  # calls the save_product method which is written at the end of the controller
  def update
    @product = Product.find(params[:id])
    upload_image if product_params[:product_image]
    if @product
      save_product
    else
      flash[:error] = "An error occured. Try adding #{@product.name} again."
    end
  end

  # ghaneyya 3an el ta3reef :D
  def destroy
    product = Product.find(params[:id])
    if product
      product.destroy
      flash[:success] = "#{product.name} has been deleted."
      redirect_to dashboard_path
    else
      flash[:error] = "An error occured. Try deleting #{@product.name} again."
    end
  end

  # update status of product, available or know
  # first: finds the product in the model with the id specified in the view
  # if there's no product with that id; do nothing
  # else change the status and save it to product
  def edit_status
    product = Product.find(product_params[:id].to_i)
    unless product.nil?
      status = product_params[:status] == "true" ? "available" : "not available"
      product.status = status
      product.save
      render json: product
    end
  end

  private

  # gets the parameters of the product so the actions can work on them
  def product_params
    params.require(:product).permit(:id, :name, :description, :price,
                                 :category_id, :product_image, :status,:prep_time)
  end

  # handle image upload
  # used cloudinary service for online upload of image
  # Cloudinary save the image on the cloud to retrieve it again when needed
  def upload_image
    image = product_params[:product_image]
    @product_image_url = false
    if image && image.size < 1.megabytes
      @upload = {}
      @upload[:product_image] = Cloudinary::Uploader.upload(image)
      @product_image_url = @upload[:product_image]["url"]
      @product[:product_image_file_name] = @product_image_url
    else
      flash[:warning] = "file size must be between 0 and 1 megabytes"
    end
    @product_image_url
  end

  # saves the image if there's any
  # saves the rest of the data with the new updates
  def save_product
    @product[:product_image_file_name] = @product_image_url
    @product.update(product_params)
    flash[:success] = "#{@product.name} has been updated successfully."
    redirect_to dashboard_path
  end
end
