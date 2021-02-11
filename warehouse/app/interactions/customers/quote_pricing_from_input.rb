require 'active_interaction'

module Customers
  # Interaction to quote customers on the pricing of storing their items
  class QuotePricingFromInput < ActiveInteraction::Base
    object :customer

    string :input

    validate :valid_json
    validate :valid_items

    def execute
      json_data = JSON.parse(input)['items']

      customer.flat_fee + calculate_pricing(json_data)
    end

    private

    def calculate_pricing(json_data)
      send("pricing_by_#{customer.charge_type}", json_data)
    end

    def pricing_by_volume(json_data)
      json_data.each_with_index.map { |item_params, index|
        # Instantiate items to access the volume method
        item = Item.new(item_params)

        price = item.volume * customer.charge_value
        discount = price * (discount_percentage_for_item_index(index + 1) / 100)

        price - discount
      }.sum
    end

    def pricing_by_value(json_data)
      json_data.each_with_index.map { |item_params, index|
        price = item_params['value'].to_f * (customer.charge_value / 100)
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
    def valid_json
      JSON.parse(input)
    rescue JSON::ParserError, TypeError
      raise ActiveInteraction::InvalidInteractionError, 'input is not a valid json'
    end

    def valid_items
      json_data = JSON.parse(input)['items']

      errors.add(:input, 'input contains invalid items') unless json_data.map { |item|
        Item.new(item.merge(customer: customer))
      }.all?(&:valid?)
    end
  end
end
