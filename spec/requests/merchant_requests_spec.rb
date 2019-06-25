require 'rails_helper'

describe "Merchants API" do
  it "returns a collection of items associated with that merchant" do
    create_list(:merchant, 5)
    
    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants.count).to eq(5)
  end
end
