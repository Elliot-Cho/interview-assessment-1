require 'active_interaction'

module Discounts
  # Interaction to create discounts
  class Create < ActiveInteraction::Base
    object :customer

    float :percentage_off
    integer :item_coverage_from, :item_coverage_to

    def to_model
      Discount.new
    end

    def execute
      discount = Discount.new(
        customer: customer,
        percentage_off: percentage_off,
        item_coverage_from: item_coverage_from,
        item_coverage_to: item_coverage_to
      )

      errors.merge!(discount.errors) unless discount.save

      discount
    end
  end
end
