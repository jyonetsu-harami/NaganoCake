class ShippingInformationsController < ApplicationController

  def index
    @shipping_information = ShippingInformation.new
    @shipping_informations = current_customer.shipping_informations
  end

  def edit
    @shipping_information = ShippingInformation.find(params[:id])
  end

  def update
    @shipping_information = ShippingInformation.find(params[:id])
		@shipping_information.update(shipping_information_params)
      redirect_to shipping_informations_path
      flash[:notice] = "配送先を編集しました。"
  end

  def create
    @shipping_information = current_customer.shipping_informations.new(shipping_information_params)
    @shipping_information.save
    redirect_to shipping_informations_path , notice: "配送先を新規登録しました"
  end

  def destroy
    @shipping_information = ShippingInformation.find(params[:id])
    @shipping_information.destroy
    flash[:notice] = "配送先を削除しました。"
    redirect_to shipping_informations_path
  end

  private
    def shipping_information_params
      params.require(:shipping_information).permit(:customer_id ,:zipcode, :address, :name)
    end

end

