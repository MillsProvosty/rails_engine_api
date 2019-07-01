class Api::V1::Transactions::InvoiceController < ApplicationController
  def show
    render json: InvoiceSerializer.new(Invoice.find_by(search_params))
  end

  def search_params
    params.permit(:id, :customer_id, :merchant_id, :status, :created_at, :updated_at)
  end
end
