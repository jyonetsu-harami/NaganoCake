module CartItemsHelper
  
  def total_amount(cart_items)
    array = []
    cart_items.each do |cart_item|
      array << cart_item.product.price*cart_item.amount
    end
    array.sum
  end
end
