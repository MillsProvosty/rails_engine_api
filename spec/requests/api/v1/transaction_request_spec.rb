require 'rails_helper'

describe "Transaction requests" do
  it "returns the associated invoice" do
    merch = create(:merchant)

    item = create(:item, merchant: merch, unit_price: 2)
    cust = create(:customer)

    invoice1 = create(:invoice, merchant: merch, customer: cust)
    invoice2 = create(:invoice, merchant: merch, customer: cust)
    invoice3 = create(:invoice, merchant: merch, customer: cust)
    invoice4 = create(:invoice, merchant: merch, customer: cust)

    inv_item1 = create(:invoice_item, item: item, invoice: invoice1, unit_price: 2)
    inv_item2 = create(:invoice_item, item: item, invoice: invoice2, unit_price: 2)
    inv_item3 = create(:invoice_item, item: item, invoice: invoice3, unit_price: 2)

    tran1 = create(:transaction, invoice: invoice1)
    tran2 = create(:transaction, invoice: invoice2)
    tran3 = create(:transaction, invoice: invoice3)
    tran4 = create(:transaction, invoice: invoice4)

    id = tran1.id

    get "/api/v1/transactions/#{id}/invoice"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)
    expect(invoice).to eq(something)
  end

end
