class Customer < ApplicationRecord
  has_many :items, dependent: :destroy

  enum charge_type: %i[volume value]

  validates :name, uniqueness: true, length: { minimum: 2 }
end

# == Schema Information
#
# Table name: customers
#
#  id           :integer          not null, primary key
#  charge_type  :integer          not null
#  charge_value :float            not null
#  flat_fee     :float            not null
#  name         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
