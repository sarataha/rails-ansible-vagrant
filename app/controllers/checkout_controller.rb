class CheckoutController < ApplicationController
  protect_from_forgery :except => [:create]

  # final checkout display with order data; displayed only when user is logged in
  def show
    if logged_in?
      @current_order.ordered_items = session[:order]["items"]
    else
      redirect_to login_path
    end
  end

  # calls update_order method to update the order data
  # calls the save_order method to save the order in db 
  # save_order method takes current user id as a parameter
  def create
    if order_params[:status].downcase === "completed"
      @current_order.update_order(session[:order], order_params)
      if @current_order.save_order(@current_user)
        session[:order] = {}
        session[:cart] = {}
        flash[:success] = "Your order has been successfully placed."
        # OrderWorker.perform_async(@current_user.id, @current_order.to_json)
        redirect_to root_path
      else
        flash[:error] = "Unable to place your order now."
        redirect_to root_path
      end
    end
  end

  # TODO create manual order by admin
  def create_manual(user_name)
    if order_params[:status].downcase === "completed"
      @current_order.update_order(session[:order], order_params)
      if @current_order.save_order(user_name)
        session[:order] = {}
        session[:cart] = {}
        flash[:success] = "Your order has been successfully placed."
        # OrderWorker.perform_async(@current_user.id, @current_order.to_json)
        redirect_to root_path
      else
        flash[:error] = "Unable to place your order now."
        redirect_to root_path
      end
    end
  end

  private

  def order_params
    { :invoice => 1233456, :status => "completed"}
  end

end

