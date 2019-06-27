class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  validates_presence_of :name

  def self.total_revenue(quantity)
    Merchant.joins(items: [invoice_items: [:invoice]])
    .select("merchants.*, SUM(invoice_items.unit_price*invoice_items.quantity) AS revenue")
    .group("merchants.id")
    .order("revenue DESC")
    .limit(quantity)
  end
end
