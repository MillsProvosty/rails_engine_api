class TransactionSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id
  belongs_to :invoices
end
