class Api::V1::Customers::SearchController < ApplicationController
  def show
    render json: CustomerSerializer.new(Customer.find_by(search_params.to_h))
  end

  def index
    render json: CustomerSerializer.new(Customer.where(search_params))
  end

  private
    def search_params
      params.permit(:id, :name, :created_at, :updated_at)
    end
end
