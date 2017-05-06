class AdministratorController < ApplicationController
  before_action :check_if_admin, only: [:show, :update]

  # Admin homepage
  def show
    @orders = Order.all.paginate(page: params[:page], per_page: 10)
  end

  # Admin page for products
  def product_index
    @products = Product.all.order(created_at: :desc)
    respond_to do |format|
      format.js
    end
  end

  # Admin page for orders
  def order_index
    @orders = Order.all.paginate(page: params[:page], per_page: 10)
    respond_to do |format|
      format.js
    end
  end

  # Admin page for users
  def user_index
    @users = User.all.paginate(page: params[:page],
                               per_page: 10).order(created_at: :desc)
    respond_to do |format|
      format.js
    end
  end

  # Admin page for category
  def category_index
    @categories = Category.all.paginate(page: params[:page], per_page: 10)
    respond_to do |format|
      format.js
    end
  end

  def update
    @title = "orders"
    @orders = Order.all.paginate(page: params[:page], per_page: 10)
    @status = params["order"]["Status"]
    @order_id = params["order_id"]
    @order = Order.find(@order_id)
    @order.update(Status: @status)
    StatusWorker.perform_async(@order_id)
    redirect_to dashboard_path
  end
end
