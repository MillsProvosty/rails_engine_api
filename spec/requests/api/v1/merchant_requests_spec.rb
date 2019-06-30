require 'rails_helper'

describe "Merchants API" do
  it "includes show action which renders a JSON representation of appropriate records" do
    merch1 = create(:merchant)
    id = merch1.id
    merch2 = create(:merchant)

    get "/api/v1/merchants/find?id=#{id}"

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

  describe "class methods" do
    it "loads_a_variable_number_of_top_merchants_ranked_by_total_revenue" do
      merch1 = create(:merchant)
      merch2 = create(:merchant)
      merch3 = create(:merchant)
      merch4 = create(:merchant)

      item1 = create(:item, merchant: merch1, unit_price: 4)
      item2 = create(:item, merchant: merch2, unit_price: 4)
      item3 = create(:item, merchant: merch3, unit_price: 4)
      item4 = create(:item, merchant: merch4, unit_price: 4)

      cust1 = create(:customer)
      cust2 = create(:customer)
      cust3 = create(:customer)
      cust4 = create(:customer)

      invoice1 = create(:invoice, customer: cust1, merchant: merch1)
      invoice2 = create(:invoice, customer: cust2, merchant: merch2)
      invoice3 = create(:invoice, customer: cust3, merchant: merch3)
      invoice4 = create(:invoice, customer: cust4, merchant: merch4)

      inv_item1 = create(:invoice_item, item: item1, quantity: 1, invoice: invoice1)
      inv_item2 = create(:invoice_item, item: item2, quantity: 2, invoice: invoice2)
      inv_item3 = create(:invoice_item, item: item3, quantity: 3, invoice: invoice3)
      inv_item4 = create(:invoice_item, item: item4, quantity: 4, invoice: invoice4)

      quantity = 3
      get "/api/v1/merchants/most_revenue?quantity=#{quantity}"

      expect(response).to be_successful

      merchants = JSON.parse(response.body)

      expect(merchants["data"].first["attributes"]["id"]).to eq(merch4.id)
      expect(merchants["data"].last["attributes"]["id"]).to eq(merch2.id)
      expect(merchants["data"].count).to eq(3)
    end

    it "loads_a_variable_number_of_top_merchants_ranked_by_total_items_sold" do
      merch1 = create(:merchant)
      merch2 = create(:merchant)
      merch3 = create(:merchant)
      merch4 = create(:merchant)

      item1 = create(:item, merchant: merch1, unit_price: 4)
      item2 = create(:item, merchant: merch2, unit_price: 4)
      item3 = create(:item, merchant: merch3, unit_price: 4)
      item4 = create(:item, merchant: merch4, unit_price: 4)

      cust1 = create(:customer)
      cust2 = create(:customer)
      cust3 = create(:customer)
      cust4 = create(:customer)

      invoice1 = create(:invoice, customer: cust1, merchant: merch1)
      invoice2 = create(:invoice, customer: cust2, merchant: merch2)
      invoice3 = create(:invoice, customer: cust3, merchant: merch3)
      invoice4 = create(:invoice, customer: cust4, merchant: merch4)

      inv_item1 = create(:invoice_item, item: item1, quantity: 1, invoice: invoice1)
      inv_item2 = create(:invoice_item, item: item2, quantity: 2, invoice: invoice2)
      inv_item3 = create(:invoice_item, item: item3, quantity: 3, invoice: invoice3)
      inv_item4 = create(:invoice_item, item: item4, quantity: 4, invoice: invoice4)

      tran1 = create(:transaction, invoice: invoice1)
      tran2 = create(:transaction, invoice: invoice2)
      tran3 = create(:transaction, invoice: invoice3)
      tran4 = create(:transaction, invoice: invoice4)


      quantity = 3

      get "/api/v1/merchants/most_items?quantity=#{quantity}"

      expect(response).to be_successful

      merchants = JSON.parse(response.body)

      expect(merchants["data"].first["attributes"]["id"]).to eq(merch4.id)
      expect(merchants["data"].last["attributes"]["id"]).to eq(merch2.id)
      expect(merchants["data"].count).to eq(3)
    end

    it "loads_the_total_revenue_across_all_transactions_associated_with_one_merchant_by_date" do
      merch1 = create(:merchant)
      merch2 = create(:merchant)
      merch3 = create(:merchant)
      merch4 = create(:merchant)

      item1 = create(:item, merchant: merch1, unit_price: 4)
      item2 = create(:item, merchant: merch2, unit_price: 4)
      item3 = create(:item, merchant: merch3, unit_price: 4)
      item4 = create(:item, merchant: merch4, unit_price: 4)

      cust1 = create(:customer)
      cust2 = create(:customer)
      cust3 = create(:customer)
      cust4 = create(:customer)

      invoice1 = create(:invoice, customer: cust1, merchant: merch1)
      invoice2 = create(:invoice, customer: cust2, merchant: merch2)
      invoice3 = create(:invoice, customer: cust3, merchant: merch3)
      invoice4 = create(:invoice, customer: cust4, merchant: merch4)

      inv_item1 = create(:invoice_item, item: item1, quantity: 1, invoice: invoice1)
      inv_item2 = create(:invoice_item, item: item2, quantity: 2, invoice: invoice2)
      inv_item3 = create(:invoice_item, item: item3, quantity: 3, invoice: invoice3)
      inv_item4 = create(:invoice_item, item: item4, quantity: 4, invoice: invoice4)

      tran1 = create(:transaction, invoice: invoice1)
      tran2 = create(:transaction, invoice: invoice2)
      tran3 = create(:transaction, invoice: invoice3)
      tran4 = create(:transaction, invoice: invoice4)


      quantity = 3
      get "/api/v1/merchants/#{merch4.id}/revenue"
      expect(response).to be_successful

      total = JSON.parse(response.body)
      expect(total["data"]["attributes"]["revenue"]).to eq("10")
    end

    it "returns the customer who has conducted the most total number of successful transactions" do
      merch4 = create(:merchant)

      item1 = create(:item, merchant: merch4, unit_price: 4)
      item2 = create(:item, merchant: merch4, unit_price: 4)
      item3 = create(:item, merchant: merch4, unit_price: 4)
      item4 = create(:item, merchant: merch4, unit_price: 4)
      item5 = create(:item, merchant: merch4, unit_price: 4)

      cust1 = create(:customer)
      cust2 = create(:customer)
      cust3 = create(:customer)

      invoice1 = create(:invoice, customer: cust1, merchant: merch4)
      invoice2 = create(:invoice, customer: cust2, merchant: merch4)
      invoice3 = create(:invoice, customer: cust3, merchant: merch4)
      invoice4 = create(:invoice, customer: cust3, merchant: merch4)
      invoice5 = create(:invoice, customer: cust3, merchant: merch4)

      inv_item1 = create(:invoice_item, item: item1, quantity: 1, invoice: invoice1)
      inv_item2 = create(:invoice_item, item: item2, quantity: 2, invoice: invoice2)
      inv_item3 = create(:invoice_item, item: item3, quantity: 3, invoice: invoice3)
      inv_item4 = create(:invoice_item, item: item4, quantity: 4, invoice: invoice4)
      inv_item5 = create(:invoice_item, item: item4, quantity: 5, invoice: invoice5)

      tran1 = create(:transaction, invoice: invoice1)
      tran2 = create(:transaction, invoice: invoice2)
      tran3 = create(:transaction, invoice: invoice3)
      tran4 = create(:transaction, invoice: invoice4)
      tran5 = create(:transaction, invoice: invoice5)

      get "/api/v1/merchants/#{merch4.id}/favorite_customer"

      expect(response).to be_successful

      customer = JSON.parse(response.body)

      expect(customer["data"]["attributes"]["favorite_customer"]["id"]).to eq(cust3.id)
    end
  end
end
