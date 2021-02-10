require 'active_interaction'

module Customers
  # Interaction to create customers
  class Create < ActiveInteraction::Base
    string :name
    integer :charge_type
    float :charge_value, :flat_fee

    def to_model
      Customer.new
    end

    def execute
      customer = Customer.new(
        name: name,
        charge_type: charge_type,
        charge_value: charge_value,
        flat_fee: flat_fee
      )

      errors.merge!(customer.errors) unless customer.save

      customer
    end
  end
end
