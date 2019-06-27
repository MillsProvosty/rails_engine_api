class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  validates_presence_of :name

  def self.total_revenue(quantity)
    Merchant.joins(items: [invoice_items: [invoice: [:transaction.]]])
    .where("transaction.result = ?", "success")
    .select("merchants.id, SUM(invoice_items.unit_price*invoice_items.quantity) AS revenue")
    .group("merchants.id")
    .order("revenue DESC")
    .limit(quantity)
  end
end
