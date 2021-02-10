require 'active_interaction'

module Items
  # Interaction to update items
  class Update < ActiveInteraction::Base
    object :item

    string :name
    float :height, :length, :width, :weight, :value

    def to_model
      item
    end

    def execute
      item.assign_attributes(
        name: name, height: height,
        length: length, width: width,
        weight: weight, value: value
      )

      errors.merge!(item.errors) unless item.save

      item
    end
  end
end
