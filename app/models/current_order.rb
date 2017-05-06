class Current_Order
  attr_accessor :ordered_items
  # attr_accessor :total
  attr_accessor :delivery_cost
  attr_accessor :sub_total
  attr_accessor :pickup_time

  def initialize(current_order)
    @ordered_items = current_order["items"] || {}
    current_order["details"] ||= {}
    @sub_total = current_order["details"]["sub_total"].to_i || 0
    @pickup_time = current_order["details"]["pickup_time"].to_i || 0
    @user = {}
    @invoice = ""
    @transaction_id = ""
    @status = "pending"
  end

  def vat
    0.1 * @sub_total
  end

  def update_order(order, args)
    @ordered_items = order["items"] || {}
    @invoice = args[:invoice] || ""
    @transaction_id = args[:transaction_id] || ""
    @status = args[:status] || "pending"
  end

  def save_order(current_user)
    user = current_user
    new_order = user.orders.new(total: @sub_total, vat: vat,
                                invoice: @invoice,
                                transaction_id: @transaction_id,)
    save_successful = new_order.save
    if save_successful
      @ordered_items.each do |index, details|
        new_order.order_items <<
          OrderItem.create(product_id: details["product"]["id"],
                           quantity: details["qty"])
      end
    end
    save_successful
  end

  def delete

  end

  private

  def add_extra_time(pick_up_time)
    if (Order.first.Status != "Delivered") || (Order.first.Status == "Cancelled")
       pick_up_time + 4
     else 
      pick_up_time
    end
  end

end
