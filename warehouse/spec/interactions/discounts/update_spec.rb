require 'rails_helper'

describe Discounts::Update do
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

  let(:new_percentage) { 15 }

  let(:discount_params) {
    {
      customer: customer,
      percentage_off: new_percentage,
      item_coverage_from: 0,
      item_coverage_to: 5
    }
  }

  let(:subject) { described_class.run!(discount_params.merge!(discount: discount)) }

  context 'when all attributes are present' do
    it 'updates discount' do
      subject

      expect(discount.reload.percentage_off).to eq(15)
    end

    context 'when attribute is invalid' do
      let(:new_percentage) { -100 }

      it 'does not update discount' do
        expect { subject }.to raise_error(ActiveInteraction::InvalidInteractionError)
      end
    end
  end

  context 'when a required attribute is missing' do
    let(:new_percentage) { nil }

    it 'does not update discount' do
      expect { subject }.to raise_error(ActiveInteraction::InvalidInteractionError)
    end
  end
end
