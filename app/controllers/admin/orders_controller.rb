class Admin::OrdersController < ApplicationController
  
  def index
    @orders = Order.page(params[:page]).reverse_order
  end
  
  def show
    @order = Order.find(params[:id])
    @customer = Customer.find(@order.customer_id)
    @order_items = @order.order_items
  end
  
  def update
    order = Order.find(params[:id])
    if order.update(order_params) && params[:order][:status] = "入金確認"
      order.order_items.update_(making_status: "制作待ち")
    end
    redirect_back fallback_location: root_path
  end
  
  private
  
  def order_params
    params.require(:order).permit(:status)
  end
end
