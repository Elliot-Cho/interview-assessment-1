require 'rails_helper'

describe Discounts::Destroy do
  let!(:customer) {
    Customer.create!(name: 'customer', charge_type: :volume, charge_value: 1, flat_fee: 1)
  }

  let!(:discount) {
    Discount.create!(
      customer: customer,
      percentage_off: 10,
      item_coverage_from: 0,
      item_coverage_to: 5
    )
  }

  let(:subject) { described_class.run!(discount: discount) }

  context 'subject' do
    it 'should destroy the discount' do
      expect { subject }.to change { Discount.count }.from(1).to(0)
    end
  end
end
