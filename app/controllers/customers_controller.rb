class CustomersController < ApplicationController

  def show
    @customer = Customer.find(current_customer.id)
  end

  def edit
    @customer = current_customer.id
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to "/my_page"
    else
      render action: :edit
    end
  end


  def unsubscribe
  end

  def withdraw
    @customer = Customer.find(current_customer.id)
    @customer.update(is_active: false)
    @customer.save
    redirect_to root_path
    flash[:notice] = "ご利用ありがとうございました。"
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name,
                                     :first_name,
                                     :last_name_kana,
                                     :first_name_kana,
                                     :email,
                                     :zipcode,
                                     :address,
                                     :phone_number,
                                     :is_active)
  end

end
