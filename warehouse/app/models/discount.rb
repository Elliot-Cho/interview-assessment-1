class Discount < ApplicationRecord
  belongs_to :customer

  validate :item_coverage_correct_order
  validate :percentage_off_within_bounds

  private

  def item_coverage_correct_order
    return if item_coverage_from.nil? || item_coverage_to.nil?
    return if item_coverage_from < item_coverage_to

    errors.add(:item_coverage_from, 'item coverage from must be less than item coverage to')
  end

  def percentage_off_within_bounds
    return if percentage_off.between?(0, 100)

    errors.add(:percentage_off, 'discount must be between 0% and 100%')
  end
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
