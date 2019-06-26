require 'rails_helper'

describe "Items API" do
  it "returns all Items" do
    merch = create(:merchant)

    create_list(:item, 10, merchant_id: merch.id)

    get "/api/v1/items"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(10)
  end

  
end
