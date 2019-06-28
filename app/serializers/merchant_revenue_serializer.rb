
class MerchantRevenueSerializer
  include FastJsonapi::ObjectSerializer

  attribute :revenue do |merch|
    merch.total_revenue.to_s
  end

end




# class MovieSerializer
#   include FastJsonapi::ObjectSerializer
#
#   attribute :name do |object|
#     "#{object.name} Part 2"
#   end
# end
