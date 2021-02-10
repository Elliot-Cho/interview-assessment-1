require 'active_interaction'

module Items
  # Interaction to find customers by id
  class Find < ActiveInteraction::Base
    integer :id

    def execute
      item = Item.find_by_id(id)

      errors.add(:id, 'does not exist') unless item

      item
    end
  end
end
