module ApplicationHelper
  
  def add_tax(price)
    (price * 1.1).floor.to_s(:delimited)
  end
end
