
class MerchantRevenueSerializer
  include FastJsonapi::ObjectSerializer

  attribute :revenue do |merch|
    merch.total_revenue.to_s
  end
end
