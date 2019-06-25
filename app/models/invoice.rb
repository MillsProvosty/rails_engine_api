class Invoice < ApplicationRecord
  belongs_to :invoice
  has_many :invoice_items
  has_many :items, through: :invoice_items

  validates_presence_of :customer_id, :merchant_id, :status
end
