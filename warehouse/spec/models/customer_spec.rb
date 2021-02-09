require 'rails_helper'

RSpec.describe Customer, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: customers
#
#  id           :integer          not null, primary key
#  charge_type  :integer          default("volume"), not null
#  charge_value :float            default(0.0), not null
#  flat_fee     :float            default(0.0), not null
#  name         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
