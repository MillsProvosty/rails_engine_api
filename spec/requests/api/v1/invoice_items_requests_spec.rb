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
end
