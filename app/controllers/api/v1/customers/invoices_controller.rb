class Api::V1::Customers::InvoicesController < ApplicationController
  def index
      render json: InvoiceSerializer.new(Invoice.all)
  end

  def show
    render json: InvoiceSerializer.new(Invoice.find(params[:id]))
  end
end
