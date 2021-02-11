require 'active_interaction'

module Discounts
  # Interaction to update discounts
  class Update < ActiveInteraction::Base
    object :discount

    float :percentage_off
    integer :item_coverage_to, default: nil
    integer :item_coverage_from, default: 0

    def to_model
      discount
    end

    def execute
      discount.assign_attributes(
        percentage_off: percentage_off,
        item_coverage_to: item_coverage_to,
        item_coverage_from: item_coverage_from
      )

      errors.merge!(discount.errors) unless discount.save

      discount
    end
  end
end
