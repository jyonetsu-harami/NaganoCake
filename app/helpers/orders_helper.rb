module OrdersHelper
  
  def billing_amount(cart_items)
    array = []
    cart_items.each do |cart_item|
      array << cart_item.product.price*cart_item.amount
    end
    cart_amount = array.sum
    cart_amount_add_tax = cart_amount * 1.1
    cart_amount_add_tax += 800
    cart_amount_add_tax.floor
  end
end
