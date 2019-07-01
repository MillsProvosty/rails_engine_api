class Api::V1::Customers::InvoicesController < ApplicationController
  def index
      render json: InvoiceSerializer.new(Invoice.all)
  end
end
