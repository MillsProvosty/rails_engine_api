require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it {should have_many :items}
    it {should have_many :invoices}
  end

  describe 'validations' do
    it {should validate_presence_of :name}
  end

  describe 'class methods' do
    before :each do
      @merch1 = create(:merchant)
      @merch2 = create(:merchant)
      @merch3 = create(:merchant)
      @merch4 = create(:merchant)

      @item1 = create(:item, merchant: @merch1, unit_price: 4)
      @item2 = create(:item, merchant: @merch2, unit_price: 4)
      @item3 = create(:item, merchant: @merch3, unit_price: 4)
      @item4 = create(:item, merchant: @merch4, unit_price: 4)
      @item5 = create(:item, merchant: @merch4, unit_price: 4)

      @cust1 = create(:customer)
      @cust2 = create(:customer)
      @cust3 = create(:customer)
      @cust4 = create(:customer)

      @invoice1 = create(:invoice, customer: @cust1, merchant: @merch1)
      @invoice2 = create(:invoice, customer: @cust2, merchant: @merch2)
      @invoice3 = create(:invoice, customer: @cust3, merchant: @merch3)
      @invoice4 = create(:invoice, customer: @cust4, merchant: @merch4)
      @invoice5 = create(:invoice, customer: @cust4, merchant: @merch4)

      @inv_item1 = create(:invoice_item, item: @item1, quantity: 1, invoice: @invoice1)
      @inv_item2 = create(:invoice_item, item: @item2, quantity: 2, invoice: @invoice2)
      @inv_item3 = create(:invoice_item, item: @item3, quantity: 3, invoice: @invoice3)
      @inv_item4 = create(:invoice_item, item: @item4, quantity: 4, invoice: @invoice4)
      @inv_item5 = create(:invoice_item, item: @item4, quantity: 5, invoice: @invoice5)

      @tran1 = create(:transaction, invoice: @invoice1)
      @tran2 = create(:transaction, invoice: @invoice2)
      @tran3 = create(:transaction, invoice: @invoice3)
      @tran4 = create(:transaction, invoice: @invoice4)
      @tran5 = create(:transaction, invoice: @invoice5)
    end

      it ".total_revenue(quanity)" do
        quantity = 3
        expect(Merchant.total_revenue(quantity)).to eq([@merch4, @merch3, @merch2])
      end

      it ".total_items_sold(quantity)" do
        quantity = 3
        expect(Merchant.total_items_sold(quantity)).to eq([@merch4, @merch3, @merch2])
      end
    end


  describe "Instance Methods" do
    before :each do
      @merch1 = create(:merchant)
      @merch2 = create(:merchant)
      @merch3 = create(:merchant)
      @merch4 = create(:merchant)

      @item1 = create(:item, merchant: @merch1, unit_price: 4)
      @item2 = create(:item, merchant: @merch2, unit_price: 4)
      @item3 = create(:item, merchant: @merch3, unit_price: 4)
      @item4 = create(:item, merchant: @merch4, unit_price: 4)
      @item5 = create(:item, merchant: @merch4, unit_price: 4)

      @cust1 = create(:customer)
      @cust2 = create(:customer)
      @cust3 = create(:customer)
      @cust4 = create(:customer)

      @invoice1 = create(:invoice, customer: @cust1, merchant: @merch1)
      @invoice2 = create(:invoice, customer: @cust2, merchant: @merch2)
      @invoice3 = create(:invoice, customer: @cust3, merchant: @merch3)
      @invoice4 = create(:invoice, customer: @cust4, merchant: @merch4)
      @invoice5 = create(:invoice, customer: @cust4, merchant: @merch4)

      @inv_item1 = create(:invoice_item, item: @item1, quantity: 1, invoice: @invoice1)
      @inv_item2 = create(:invoice_item, item: @item2, quantity: 2, invoice: @invoice2)
      @inv_item3 = create(:invoice_item, item: @item3, quantity: 3, invoice: @invoice3)
      @inv_item4 = create(:invoice_item, item: @item4, quantity: 4, invoice: @invoice4)
      @inv_item5 = create(:invoice_item, item: @item4, quantity: 5, invoice: @invoice5)

      @tran1 = create(:transaction, invoice: @invoice1)
      @tran2 = create(:transaction, invoice: @invoice2)
      @tran3 = create(:transaction, invoice: @invoice3)
      @tran4 = create(:transaction, invoice: @invoice4)
      @tran5 = create(:transaction, invoice: @invoice5)
    end

    it "#total_revenue" do
      expect(@merch4.total_revenue).to eq(15)
    end

    # it "#total_revenue_date(date)" do
    #   date_arg = "2012-03-27 14:54:09 UTC"
    #   date = date_arg.slice(0..9)
    #   expect(@merch4.total_revenue_date(date)).to eq(4)
    # end

    it "favorite customer" do
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

      expect(merch4.favorite_customer).to eq(cust3)
    end
  end
end
