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
      # Instantiate items to access the volume method
      total_volume = json_data.map { |item| Item.new(item).volume }.sum

      total_volume * customer.charge_value
    end

    def pricing_by_value(json_data)
      total_value = json_data.map { |item| item['value'].to_f }.sum

      customer.charge_value / 100 * total_value
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
