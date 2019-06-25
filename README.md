# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation
I used the   CSV.foreach('path', headers: true, header_converters: :symbol)   
  do |row|
    Class.create(row.to_hash)
  end
  There was a major change I needed to make in the migrations: credit card numbers needed to be changed from integers to strings.

  The command used to populate the database is rake import:data

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
