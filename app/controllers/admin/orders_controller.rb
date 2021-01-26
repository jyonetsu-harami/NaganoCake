class Admin::OrdersController < ApplicationController
  
  def index
  # params[:customer_id]に値が入っていたら@ordersにその顧客の注文一覧を代入する
    if params[:customer_id].present?
      @orders = Customer.find(params[:customer_id]).orders.page(params[:page]).per(10).reverse_order
    else
      @orders = Order.page(params[:page]).per(10).reverse_order
    end
  end
  
  def show
    @order = Order.find(params[:id])
    @customer = Customer.find(@order.customer_id)
    @order_items = @order.order_items
  end
  
  def update
    order = Order.find(params[:id])
    if order.update(order_params) && params[:order][:status] == "入金確認"
      order.order_items.update(making_status: "制作待ち")
    end
    redirect_back fallback_location: root_path
  end
  
  private
  
  def order_params
    params.require(:order).permit(:status, )
  end
end
