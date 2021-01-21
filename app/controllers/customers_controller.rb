class CustomersController < ApplicationController
  
  def show
  end
  
  def edit
  end
  
  def update
  end
  
  def unsubscribe
  end

  def withdraw
  end 
  
  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :zipcode, :address, :phone_number, :is_active)
  end
  
end
