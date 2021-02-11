require 'active_interaction'

module Discounts
  # Interaction to find customers by id
  class Find < ActiveInteraction::Base
    integer :id

    def execute
      discount = Discount.find_by_id(id)

      errors.add(:id, 'does not exist') unless discount

      discount
    end
  end
end
