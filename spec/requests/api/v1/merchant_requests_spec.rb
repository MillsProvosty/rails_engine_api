require 'rails_helper'

describe "Merchants API" do
  it "includes show action which renders a JSON representation of appropriate records" do
    merch1 = create(:merchant)
    id = merch1.id
    merch2 = create(:merchant)

    get "/api/v1/merchants/find?id=#{id} "

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"]["id"].to_i).to eq(merch1["id"])
    expect(merchants["data"]["id"].to_i).to_not eq(merch2["id"])
  end

  it "includes index action which renders a JSON representation of appropriate records" do
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

  it "returns a all merchants" do
    create_list(:merchant, 5)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"].count).to eq(5)
  end

  it "returns a single merchant" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    expect(response).to be_successful
    merchant = JSON.parse(response.body)

    expect(merchant["data"]["id"].to_i).to eq(id)
  end

  it "returns a collection of items associated with that merchant" do
    merch = create(:merchant)
    create_list(:item, 3, merchant_id: merch["id"])

    get "/api/v1/merchants/#{merch["id"]}/items"

    expect(response).to be_successful
    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(3)
  end

  it " returns a collection of invoices associated with that merchant from their known orders" do
    merch = create(:merchant)
    cust = create(:customer)
    create_list(:invoice, 4, merchant_id: merch["id"], customer: cust)

    get "/api/v1/merchants/#{merch["id"]}/invoices"

    expect(response).to be_successful
    invoices = JSON.parse(response.body)

    expect(invoices["data"].count).to eq(4)
  end
end
