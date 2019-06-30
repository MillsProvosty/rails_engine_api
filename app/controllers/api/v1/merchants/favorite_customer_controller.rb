class Api::V1::Merchants::FavoriteCustomerController < ApplicationController
  def show
    render json: MerchantFavoriteCustomerSerializer.new(Merchant.find(params["id"]))
  end
end
