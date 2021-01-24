module Admin::OrdersHelper
  def order_quantity(order)
    array = []
    order.order_items.each do |order_item|
      array << order_item.amount
    end
    array.sum
  end
end
