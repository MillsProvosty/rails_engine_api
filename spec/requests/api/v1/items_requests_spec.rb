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

  it "returns specific item" do
    merch = create(:merchant)
    id = create(:item, merchant: merch).id


    get "/api/v1/items/#{id}"

    expect(response).to be_successful
    item = JSON.parse(response.body)

    expect(item["data"]["id"].to_i).to eq(id)
  end

  it "returns a collection of associated invoice items" do
    merch = create(:merchant)
    item = create(:item, merchant: merch)
    invoice = create(:invoice, merchant: merch)
    inv_item = create_list(:invoice_item, 5, item: item, invoice: invoice)

    get "/api/v1/items/#{item["id"]}/invoice_items"

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)

    expect(invoice_items["data"].count).to eq(5)
  end

  it "returns the associated merchant" do
    id = create(:merchant).id
    item = create(:item, merchant: merch)

    get "/api/v1/items/#{item["id"]}/merchant"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant["data"]["id"]).to eq(id)
  end


end
