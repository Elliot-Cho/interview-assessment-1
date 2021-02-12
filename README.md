# Second Closet Assessment

This repo contains my solution for Second Closet's take-home technical assessment.

## Author

* Elliot Cho

## Built With

* Ruby 2.7.2
* Rails 6.1.1
* sqlite3

## Usage Documentation

### Requirements
* Ruby 2.7.2 & Rails
* Bundler
* Node.js
* Yarn
* Webpacker

### How to Launch:
* Clone this repository
* Have the requirements installed
* Run: `bundle e rails db:setup` to setup and seed the sqlite3 database
* Run: `bundle e rails s`

### How to Use:
* To create or edit customer data, pricing and discounts, access the local server `localhost:3000` and use the (really ugly) UI to make changes.
* A customer can be quoted for prices in one of two ways:
  1. Use the ugly UI to add items to a customer. The customer page should update with a price quote for that customer's current set of items, given their pricing.
  2. Hit the `quote_from_input` endpoint using direct input or from a file:
  * Direct input:
    * ```curl -X GET -i -H "Accept: application/json" -H "Content-Type application/json" -d {data here} "http://localhost:3000/customers/{customer id}/quote_from_input"```
  * From a file:
    * ```curl -X GET -i -H "Accept: application/json" -H "Content-Type application/json" --data-binary "@{path to file}" "http://localhost:3000/customers/{customer id}/quote_from_input"```
    
Examples:
* Direct:
  * ```curl -X GET -i -H "Accept: application/json" -H "Content-Type application/json" -d "{\"items\": [{\"name\": \"Fridge\", \"length\": \"3\", \"height\": \"6\", \"width\": \"4\", \"weight\": \"300\", \"value\": \"1000\"}, {\"name\": \"Sofa\", \"length\": \"6\", \"height\": \"4\", \"width\": \"3\", \"weight\": \"100\", \"value\": \"500\"}]}" "http://localhost:3000/customers/1/quote_from_input"```
* From File
  * ```curl -X GET -i -H "Accept: application/json" -H "Content-Type application/json" --data-binary "@\Desktop\testfile.txt" "http://localhost:3000/customers/5/quote_from_input"```
  
## Issues:
* Styling and frontend not yet implemented
* Authentication & security not yet implemented
