require 'active_interaction'

module Customers
  # Interaction to find customers by id
  class Find < ActiveInteraction::Base
    integer :id

    def execute
      customer = Customer.find_by_id(id)

      errors.add(:id, 'does not exist') unless customer

      customer
    end
  end
end
