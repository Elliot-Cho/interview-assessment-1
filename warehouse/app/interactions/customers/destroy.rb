require 'active_interaction'

module Customers
  # Interaction to destroy customers
  class Destroy < ActiveInteraction::Base
    object :customer

    def execute
      customer.destroy
    end
  end
end
