require 'rails_helper'

RSpec.describe Discount, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: discounts
#
#  id                 :integer          not null, primary key
#  item_coverage_from :integer
#  item_coverage_to   :integer
#  percentage_off     :float            not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  customer_id        :integer          not null
#
# Indexes
#
#  index_discounts_on_customer_id  (customer_id)
#
# Foreign Keys
#
#  customer_id  (customer_id => customers.id)
#
