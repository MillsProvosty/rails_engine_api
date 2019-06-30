# README

* Project
  This project was my first experience in using Rails and ActiveRecord to build a JSON API which exposes the SalesEngine data schema. While I did not complete the project in the seven days allotted, I am proud of my work and have written a blog that documents my progress and challeneges.
  

* Ruby version
  ruby '2.4.1'
  ActiveRecord - PostgreSQL

* Gems added
  rspec-rails:  
    -run bundle install
    -run rails generate rspec:install
  factory_bot_rails:
    -in the rails_helper folder, find RSpec.configure do |config|
    -add: config.include FactoryBot::Syntax::Methods
  pry:
  shoulda-matchers:
    -in the rails_helper folder, under all text add the following code:
    Shoulda::Matchers.configure do |config|
      config.integrate do |with|
        with.test_framework :rspec
        with.library :rails
      end
    end
  faker:
  fast_jsonapi:

* Setup
  Clone the GitHub repository.
  cd rails_engine_api
  Run bundle install.
  Run rails import:data

* How to run the test suite
  -To run rspec on project
    -from rails_engine_api run rpsec
  -To run the spec harness on the project
    -cd up one directory
    -Clone the GitHub repository: https://github.com/turingschool/rales_engine_spec_harness
    -cd rales_engine_spec_harness
    -Run bundle install
    -run rake

* Configuration

* Database creation
  The command used to populate the database is rake import:data
