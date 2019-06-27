class Api::V1::Merchants::MostItemsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.total_items_sold(params["quantity"].to_i))
  end
end
