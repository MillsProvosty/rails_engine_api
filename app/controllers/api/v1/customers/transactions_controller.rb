class Api::V1::Customers::TransactionsController < ApplicationController
  def index
    render json: TransactionSerializer.new(Transaction.all)
  end
end
