require 'csv'
namespace :import do
  #look up rake commands to add to drop, create migrate and seed database
  desc "imports data from a csv file" #see when this task runs
  task :data => :environment do
    #before we run data task, run the environment (rake task that rails gives us) task

    CSV.foreach('./db/data/customers.csv', headers: true, header_converters: :symbol) do |row|
      Customer.create(row.to_hash)
    end

    CSV.foreach('./db/data/merchants.csv', headers: true, header_converters: :symbol) do |row|
      Merchant.create(row.to_hash)
    end

    CSV.foreach('./db/data/transactions.csv', headers: true, header_converters: :symbol) do |row|
      Transaction.create(row.to_hash)
    end

    CSV.foreach('./db/data/invoices.csv', headers: true, header_converters: :symbol) do |row|
      Invoice.create(row.to_hash)
    end

    CSV.foreach('./db/data/items.csv', headers: true, header_converters: :symbol) do |row|
      Item.create(row.to_hash)
    end

    CSV.foreach('./db/data/invoice_items.csv', headers: true, header_converters: :symbol) do |row|
      InvoiceItem.create(row.to_hash)
    end
  end
end
