require 'rails_helper'

describe "Customer Requests" do
  it "returns a collection of associated invoices" do
    merch = create(:merchant)
    item = create(:item, merchant: merch)
    cust = create(:customer)
    invoice1 = create(:invoice, merchant: merch, customer: cust)
    invoice2 = create(:invoice, merchant: merch, customer: cust)
    invoice3 = create(:invoice, merchant: merch, customer: cust)
    inv_item1 = create(:invoice_item, item: item, invoice: invoice1)
    inv_item2 = create(:invoice_item, item: item, invoice: invoice2)
    inv_item3 = create(:invoice_item, item: item, invoice: invoice3)


    get "/api/v1/customers/:id/invoices"
    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers["data"].first["attributes"]["customer_id"]).to eq(cust.id)
  end
end
