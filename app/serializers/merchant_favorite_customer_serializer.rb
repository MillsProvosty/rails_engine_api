class MerchantFavoriteCustomerSerializer
  include FastJsonapi::ObjectSerializer
  
  attribute :favorite_customer do |merch|
    merch.favorite_customer
  end

end
