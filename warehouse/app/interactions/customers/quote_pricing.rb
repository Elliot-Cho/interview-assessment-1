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
      ordered_items = customer.items.order(:created_at)

      ordered_items.each_with_index.map { |item, index|
        price = item.volume * customer.charge_value
        discount = price * (discount_percentage_for_item_index(index + 1) / 100)

        price - discount
      }.sum
    end

    def pricing_by_value
      ordered_items = customer.items.order(:created_at)

      ordered_items.each_with_index.map { |item, index|
        price = item.value * (customer.charge_value / 100)
        discount = price * (discount_percentage_for_item_index(index + 1) / 100)

        price - discount
      }.sum
    end

    def discount_percentage_for_item_index(index)
      discount = customer.discounts.find_by(
        'item_coverage_from <= ? AND (item_coverage_to IS NULL OR item_coverage_to >= ?)',
        index,
        index
      )

      discount ? discount.percentage_off : 0
    end

    # Validation
    def customer_has_items
      errors.add(:item, 'customer has no items') unless customer.items.any?
    end
  end
end
