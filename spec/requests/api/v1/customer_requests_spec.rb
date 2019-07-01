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

  it "returns a collection of associated transactions" do
    merch = create(:merchant)
    merch2 = create(:merchant)
    item = create(:item, merchant: merch)
    cust = create(:customer)
    cust2 = create(:customer)
    invoice1 = create(:invoice, merchant: merch, customer: cust)
    invoice2 = create(:invoice, merchant: merch, customer: cust)
    invoice3 = create(:invoice, merchant: merch, customer: cust)
    invoice4 = create(:invoice, merchant: merch, customer: cust)
    invoice5 = create(:invoice, merchant: merch, customer: cust2)
    inv_item1 = create(:invoice_item, item: item, invoice: invoice1)
    inv_item2 = create(:invoice_item, item: item, invoice: invoice2)
    inv_item3 = create(:invoice_item, item: item, invoice: invoice3)
    inv_item3 = create(:invoice_item, item: item, invoice: invoice5)
    tran1 = create(:transaction, invoice: invoice1)
    tran2 = create(:transaction, invoice: invoice2)
    tran3 = create(:transaction, invoice: invoice3)
    tran4 = create(:transaction, invoice: invoice4)
    tran5 = create(:transaction, invoice: invoice5)

    get "/api/v1/customers/:id/transactions"
    expect(response).to be_successful

    transactions = JSON.parse(response.body)

    expect(transactions["data"].first["attributes"]["id"]).to eq(tran1.id)
    expect(transactions["data"].first["attributes"]["id"]).to_not eq(tran5.id)

  end
end
