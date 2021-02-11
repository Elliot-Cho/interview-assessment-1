require 'rails_helper'

RSpec.describe Discount, type: :model do
  let!(:customer) {
    Customer.create!(name: 'customer', charge_type: :volume, charge_value: 1, flat_fee: 1)
  }

  let(:percentage_off) { 10 }
  let(:item_coverage_from) { 0 }
  let(:discount_params) {
    {
      customer: customer,
      percentage_off: percentage_off,
      item_coverage_from: item_coverage_from,
      item_coverage_to: 2
    }
  }

  let(:discount) { Discount.new(discount_params) }

  context 'when all attributes are present' do
    it 'can create discount' do
      expect(discount.save).to eq(true)
    end

    context 'if percentage value is invalid' do
      let(:percentage_off) { 1000 }

      it 'fails validation' do
        expect { discount.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'if item coverage from is larger than item coverage to' do
      let(:item_coverage_from) { 50 }

      it 'fails validation' do
        expect { discount.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  context 'when required attribute is missing' do
    let(:percentage_off) { nil }

    it 'cannot create discount' do
      expect { discount.save! }.to raise_error(ActiveRecord::NotNullViolation)
    end
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
