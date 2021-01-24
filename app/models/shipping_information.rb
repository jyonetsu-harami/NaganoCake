class ShippingInformation < ApplicationRecord
  belongs_to :customer

  def merge_zipcode_to_name
    "〒" + self.zipcode + " " + self.address + " " + self.name
  end
  
  def merge_zipcode_to_address
    "〒" + self.zipcode + " " + self.address
  end
end
