# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

customer_a = Customer.create(name: 'Customer A', charge_type: :volume, charge_value: 3, flat_fee: 20)
Customer.create(name: 'Customer B', charge_type: :volume, charge_value: 1, flat_fee: 20)
Customer.create(name: 'Customer C', charge_type: :value, charge_value: 5, flat_fee: 20)
customer_d = Customer.create(name: 'Customer D', charge_type: :volume, charge_value: 2, flat_fee: 20)

Discount.create(customer: customer_a, percentage_off: 10, item_coverage_from: 0)
Discount.create(customer: customer_d, percentage_off: 5, item_coverage_from: 0, item_coverage_to: 100)
Discount.create(customer: customer_d, percentage_off: 10, item_coverage_from: 101, item_coverage_to: 200)
Discount.create(customer: customer_d, percentage_off: 15, item_coverage_from: 201)
