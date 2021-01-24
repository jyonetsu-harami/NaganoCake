class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :shipping_informations, dependent: :destroy
  

  def full_name
    self.last_name + " " + self.first_name
  end
  
  def merge_zipcode_to_address
    "〒" + self.zipcode + " " + self.address
  end
  
  def active_for_authentication?
    super && self.is_active == true
  end
end
