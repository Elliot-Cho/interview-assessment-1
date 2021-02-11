class Item < ApplicationRecord
  belongs_to :customer

  validates :name, length: { minimum: 2 }
  validates :length, :height, :width, presence: true

  def volume
    length * width * height
  end
end

# == Schema Information
#
# Table name: items
#
#  id          :integer          not null, primary key
#  height      :float            not null
#  length      :float            not null
#  name        :string           not null
#  value       :float
#  weight      :float
#  width       :float            not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  customer_id :integer          not null
#
# Indexes
#
#  index_items_on_customer_id  (customer_id)
#
# Foreign Keys
#
#  customer_id  (customer_id => customers.id)
#
