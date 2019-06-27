require 'rails_helper'

describe "Items API" do
  it "includes show action which renders a JSON representation of appropriate records" do
    merch = create(:merchant)
    item1 = create(:item, merchant: merch)
    id = item1.id
    item2 = create(:item, merchant: merch)
    get "/api/v1/items/find?id=#{id}"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"]["id"].to_i).to eq(item1["id"])
    expect(items["data"]["id"].to_i).to_not eq(item2["id"])
  end

  xit "includes index action which renders a JSON representation of appropriate records" do
    merch1 = create(:merchant)
    merch2 = create(:merchant)
    merch3 = create(:merchant)
    name = merch3.name
    merch4 = create(:merchant)
    merch5 = create(:merchant)
    merch6 = create(:merchant)
    merch7 = create(:merchant)
    merch8 = create(:merchant)
    merch9 = create(:merchant)
    merch10 = create(:merchant, name: "Joe")

    get "/api/v1/merchants/find_all?name=#{name}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant["data"].count).to eq(9)
  end

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
    cust = create(:customer)
    invoice = create(:invoice, merchant: merch, customer: cust)
    inv_item = create_list(:invoice_item, 5, item: item, invoice: invoice)

    get "/api/v1/items/#{item["id"]}/invoice_items"

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)

    expect(invoice_items["data"].count).to eq(5)
  end

  it "returns the associated merchant" do
    merch = create(:merchant)
    id = merch.id
    item = create(:item, merchant: merch)

    get "/api/v1/items/#{item["id"]}/merchants"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant["data"].first["id"].to_i).to eq(id)
  end


end
