require 'active_interaction'

module Discounts
  # Interaction to destroy discounts
  class Destroy < ActiveInteraction::Base
    object :discount

    def execute
      discount.destroy
    end
  end
end
