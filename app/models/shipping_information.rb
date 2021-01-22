class ShippingInformation < ApplicationRecord
  belongs_to :customer

  def merge_shipping_information
    "〒" + self.zipcode + " " + self.address + " " + self.name
  end
end
