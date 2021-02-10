require 'active_interaction'

module Items
  # Interaction to create items
  class Create < ActiveInteraction::Base
    object :customer
    string :name
    float :height, :length, :width, :weight, :value

    def to_model
      Item.new
    end

    def execute
      item = Item.new(
        customer: customer,
        name: name,
        height: height,
        length: length,
        width: width,
        weight: weight,
        value: value
      )

      errors.merge!(item.errors) unless item.save

      item
    end
  end
end
