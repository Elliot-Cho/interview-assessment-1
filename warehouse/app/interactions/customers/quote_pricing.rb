require 'active_interaction'

module Customers
  # Interaction to quote customers on the pricing of storing their items
  class QuotePricing < ActiveInteraction::Base
    object :customer, class: Customer

    validate :customer_has_items

    def execute
      ::CustomerHelper::PriceQuoter.quote_pricing(customer, customer.items)
    end

    private

    # Validation
    def customer_has_items
      errors.add(:item, 'customer has no items') unless customer.items.any?
    end
  end
end
