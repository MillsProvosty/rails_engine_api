require 'rails_helper'

describe "Invoice Items Requests" do
  it "shows all invoice items" do
    merch = create(:merchant)
    item = create(:item, merchant: merch)
    invoice = create(:invoice, merchant: merch)
    inv_item = create_list(:invoice_item, 5, item: item, invoice: invoice)

    get "/api/v1/invoice_items"

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)

    expect(invoice_items["data"].count).to eq(5)
  end

  it "shows an individual invoice item" do
    merch = create(:merchant)
    item = create(:item, merchant: merch)
    invoice = create(:invoice, merchant: merch)
    inv_item = create(:invoice_item, item: item, invoice: invoice)
    id = inv_item.id

    get "/api/v1/invoice_items/#{id}"

     expect(response).to be_successful

     invoice_item = JSON.parse(response.body)

     expect(invoice_item["data"]["id"].to_i).to eq(id)

  end

  it "returns the associated invoice" do
    merch = create(:merchant)
    item = create(:item, merchant: merch)
    invoice = create(:invoice, merchant: merch)
    inv_item = create(:invoice_item, item: item, invoice: invoice)
    id = inv_item.id

    get "/api/v1/invoice_items/#{id}/invoices"

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)

    expect(invoice_items["data"].first["id"].to_i).to eq(invoice["id"])
  end

  it " returns the associated item" do
    merch = create(:merchant)
    item = create(:item, merchant: merch)
    invoice = create(:invoice, merchant: merch)
    inv_item = create(:invoice_item, item: item, invoice: invoice)
    id = inv_item.id

    get "/api/v1/invoice_items/#{id}/items"

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)

    expect(invoice_items["data"].first["id"].to_i).to eq(item["id"])
  end
end
