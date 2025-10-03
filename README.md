# README

# Restaurant API

## Ruby version
- 3.3.0

## System dependencies
- I recommend using RVM or rbenv to manage Ruby versions
- Docker and Docker Compose for database setup

## Configuration

Start the Docker environment:

```bash
docker compose up
# or
docker-compose up

This will start the PostgreSQL database and create the default schema restaurant_api using init.sql.
```

## Database setup

Create and migrate the database:

```bash
rails db:create
rails db:migrate
```
    
## Database initialization

I prepared some seeds with some of our typical brazilian food hehe

```bash
rails db:seed
```

## How to run the test suite
First, create the test database:
```bash
RAILS_ENV=test rails db:create
```
Then run all tests with RSpec:
```bash
rspec
```
## Importing restaurant data

1. Using the Rake task
```bash
bundle exec rake import:restaurants FILE=path/to/restaurant_data.json
```

2. Using the HTTP POST endpoint
```bash
curl --location 'http://localhost:3000/imports' \
--header 'Content-Type: application/json' \
--data '{
    "restaurants": [
        {
            "name": "Poppo'\''s Cafe",
            "menus": [
                {
                    "name": "lunch",
                    "menu_items": [
                        { "name": "Burger", "price": 9.00 },
                        { "name": "Small Salad", "price": 5.00 }
                    ]
                },
                {
                    "name": "dinner",
                    "menu_items": [
                        { "name": "Burger", "price": 15.00 },
                        { "name": "Large Salad", "price": 8.00 }
                    ]
                }
            ]
        },
        {
            "name": "Casa del Poppo",
            "menus": [
                {
                    "name": "lunch",
                    "dishes": [
                        { "name": "Chicken Wings", "price": 9.00 },
                        { "name": "Burger", "price": 9.00 },
                        { "name": "Chicken Wings", "price": 9.00 }
                    ]
                },
                {
                    "name": "dinner",
                    "dishes": [
                        { "name": "Mega \"Burger\"", "price": 22.00 },
                        { "name": "Lobster Mac & Cheese", "price": 31.00 }
                    ]
                }
            ]
        }
    ]
}'
```
The endpoint accepts menu_items or dishes as keys in the JSON

Logs and success/failure status will be returned in the JSON response

## Notes

MenuItem names are unique in the system, but a single MenuItem can belong to multiple menus.

MenuItems will have their price updated if the imported JSON specifies a different value.

This system follows Rails conventions with shallow routes for menus and menu_items.