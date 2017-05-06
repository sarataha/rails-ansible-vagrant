class CartsController < ApplicationController
  def index
    if logged_in?
      @cart_items = session[:cart]
      @ordered_products = {}
      @total = 0
      @cart_items.each do |product_id, qty|
        product = Product.find_by_id(product_id)
        @ordered_products[product_id] = { product: product, qty: qty }
        check_product_status(product, qty, product_id)
      end unless session[:cart].nil?
      @current_order.ordered_items = @ordered_products
      session[:order]["items"] = @ordered_products
    else
      redirect_to login_path
    end
  end

  def destroy
    product_id = params[:id]
    @cart.cart_data.delete(product_id)
    redirect_to carts_path
  end

  def check_product_status(product, qty, product_id)
    unless product.status == "available"
      @ordered_products.delete(product_id)
    else
      price = product.price
      @total += (price * qty)
    end
  end

private

  # def line_prep_total(qty, prep_time) 
  #   added_time = ((qty/7) * 10) + prep_time
  # end

  # def add_extra_time(pick_up_time)
  #   unless Order.first.nil?
  #     if (Order.first.Status != "Delivered")
  #       pick_up_time + 4
  #     else 
  #       pick_up_time
  #     end
  #   else
  #   pick_up_time
  #   end
  # end

end
