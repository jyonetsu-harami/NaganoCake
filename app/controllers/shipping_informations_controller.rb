class ShippingInformationsController < ApplicationController

  def index
    @shipping_information = ShippingInformation.new
    @shipping_informations = current_customer.shipping_informations
  end

  def edit
    @shipping_information = ShippingInformation.find(params[:id]) 
  end

  def update
    @shipping_information = current_customer.shipping_informations.find(params[:id])
    @shipping_information.update(shipping_information_params)
    redirect_to customer_shipping_informations_path , notice: "配送先情報を更新しました"
  end

  def create
    @shipping_information = current_customer.shipping_informations.new(shipping_information_params)
    @shipping_information.save
    redirect_to shipping_informations_path , notice: "配送先を新規登録しました"
  end

  def destory
    @shipping_information = current_customer.shipping_informations.find(params[:id])
  	@shipping_information.destory
  	redirect_to shipping_information_path , notice: "配送先を削除しました"
  end

  private
    def shipping_information_params
      params.permit(:customer_id ,:zipcode, :address, :name)
    end

end

