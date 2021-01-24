class ShippingInformation < ApplicationRecord
    belongs_to :customer

    def shipping_address_and_name
      "〒  " + self.zipcode + "  " + self.address + "  " + self.name
    end
end
