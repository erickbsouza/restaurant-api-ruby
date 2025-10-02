# README

* Ruby version
    - 3.3.0

* System dependencies
    - I recommend using RVM to manage ruby versions

* Configuration
    run docker compose up or docker-compose up depending on the version you have installed.
    This will create the database with the variables used in the docker-compose.yml
    It also creates the default schema restaurant_api using the init.sql

* Database creation
    rails db:create rails db:migrate will create all the database and migrate will create our tables
    
* Database initialization

* How to run the test suite
    To  run the tests suites you need to first run  RAILS_ENV=test rails db:create so rails will create our test database
    run rspec to run unit tests

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
