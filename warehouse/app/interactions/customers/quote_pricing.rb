require 'active_interaction'

module Customers
  # Interaction to quote customers on the pricing of storing their items
  class QuotePricing < ActiveInteraction::Base
    object :customer

    validate :customer_has_items

    def execute
      customer.flat_fee + calculate_pricing
    end

    private

    def calculate_pricing
      send("pricing_by_#{customer.charge_type}")
    end

    def pricing_by_volume
      total_volume = customer.items.map(&:volume).sum

      total_volume * customer.charge_value
    end

    def pricing_by_value
      total_value = customer.items.map(&:value).sum

      customer.charge_value / total_value * 100
    end

    # Validation
    def customer_has_items
      errors.add(:item, 'customer has no items') unless customer.items.any?
    end
  end
end
