class ShippingInformation < ApplicationRecord
  belongs_to :customer
    
  #配送先住所の結合(注文関連で使用)
  def address_all
    "〒" + self.zipcode + "　" + self.address + "　" + self.name 
  end  

end
