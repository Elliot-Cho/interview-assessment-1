require 'active_interaction'

module Items
  # Interaction to destroy items
  class Destroy < ActiveInteraction::Base
    object :item

    def execute
      item.destroy
    end
  end
end
