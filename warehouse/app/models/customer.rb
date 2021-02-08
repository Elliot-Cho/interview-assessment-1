class Customer < ApplicationRecord
  enum charge_type: [ :volume, :value ]
end

# == Schema Information
#
# Table name: customers
#
#  id           :integer          not null, primary key
#  charge_type  :integer
#  charge_value :float
#  flat_fee     :float
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
