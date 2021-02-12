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
* Run: `bundle install` to install necessary gems
* Run: `bundle e rails db:setup` to setup and seed the sqlite3 database
* In the 'warehouse' directory of the project, rn: `bundle e rails s` to run the server

### How to Use:
* To create or edit customer data, pricing and discounts, access the local server `localhost:3000` and use the (really ugly) UI to make changes.
* A customer can be quoted for prices in one of two ways:
  1. Use the ugly UI to add items to a customer. The customer page should update with a price quote for that customer's current set of items, given their pricing.
  2. With the server running locally, hit the `quote_from_input` endpoint using direct input or input from a file:
  * Direct input:
    * ```curl -X GET -i -H "Accept: application/json" -H "Content-Type application/json" -d {data here} "http://localhost:3000/customers/{customer id}/quote_from_input"```
  * From a file:
    * ```curl -X GET -i -H "Accept: application/json" -H "Content-Type application/json" --data-binary "@{path to file}" "http://localhost:3000/customers/{customer id}/quote_from_input"```
    
* Json input should be in this format:
```
{
	"items": [
		{
			"name": "Fridge",
			"length": "3",
			"height": "6",
			"width": "4",
			"weight": "300",
			"value": "1000"
		},
		{
			"name": "Sofa",
			"length": "6",
			"height": "4",
			"width": "3",
			"weight": "100",
			"value": "500"
		}
	]
}
```
    
Examples:
* Direct:
  * ```curl -X GET -i -H "Accept: application/json" -H "Content-Type application/json" -d "{\"items\": [{\"name\": \"Fridge\", \"length\": \"3\", \"height\": \"6\", \"width\": \"4\", \"weight\": \"300\", \"value\": \"1000\"}, {\"name\": \"Sofa\", \"length\": \"6\", \"height\": \"4\", \"width\": \"3\", \"weight\": \"100\", \"value\": \"500\"}]}" "http://localhost:3000/customers/1/quote_from_input"```
* From File
  * ```curl -X GET -i -H "Accept: application/json" -H "Content-Type application/json" --data-binary "@\Desktop\testfile.txt" "http://localhost:3000/customers/5/quote_from_input"```
  
Note: `quote_from_input` will not write item data to the database, it only returns the price quote.
  
## Issues:
* Styling and frontend not yet implemented
* Authentication & security not yet implemented
