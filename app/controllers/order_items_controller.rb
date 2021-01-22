class OrderItemsController < ApplicationController
  def create
    cart_items = current_customer.cart_items
    cart_items.each do |cart_item|
      tax_in_price = cart_item.product.price * 1.1
      order_item = OrderItem.new(
        order_id: params[:order_id],
        product_id: cart_item.product_id,
        amount: cart_item.amount,
        tax_in_price: tax_in_price.floor
        )
      order_item.save
    end
    current_customer.cart_items.destroy_all
    redirect_to  order_success_orders_path
  end
end
