require 'active_interaction'

module Customers
  # Interaction to update customers
  class Update < ActiveInteraction::Base
    object :customer

    string :name
    integer :charge_type
    float :charge_value, :flat_fee

    def to_model
      customer
    end

    def execute
      customer.assign_attributes(
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
