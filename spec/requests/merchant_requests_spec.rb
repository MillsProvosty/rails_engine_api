require 'rails_helper'

describe "Merchants API" do
  it "returns a collection of items associated with that merchant" do
    create_list(:merchant, 5)

    get '/api/v1/merchants/:id/items'

    expect(response).to be_successful

    binding.pry
  end
end
