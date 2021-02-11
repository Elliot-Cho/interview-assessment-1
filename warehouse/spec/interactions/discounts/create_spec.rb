require 'rails_helper'

describe Discounts::Create do
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

  let(:subject) { described_class.run!(discount_params) }

  context 'when all attributes are present' do
    it 'creates discount' do
      expect { subject }.to change { Discount.count }.from(0).to(1)
    end

    context 'when percentage off is invalid' do
      let(:percentage_off) { 1000 }

      it 'does not create discount' do
        expect { subject }.to raise_error(ActiveInteraction::InvalidInteractionError)
      end
    end

    context 'when item coverage values are invalid' do
      let(:item_coverage_from) { 50 }

      it 'does not create discount' do
        expect { subject }.to raise_error(ActiveInteraction::InvalidInteractionError)
      end
    end
  end

  context 'when a required attribute is missing' do
    let(:percentage_off) { nil }

    it 'does not create discount' do
      expect{ subject }.to raise_error(ActiveInteraction::InvalidInteractionError)
    end
  end
end
