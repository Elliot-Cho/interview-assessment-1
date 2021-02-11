require 'rails_helper'

describe Items::Create do
  let!(:customer) {
    Customer.create!(name: 'customer', charge_type: :volume, charge_value: 1, flat_fee: 1)
  }

  let(:name) { 'box' }

  let(:item_params) {
    {
      customer: customer,
      name: name,
      height: 5,
      length: 4,
      width: 5,
      weight: 100,
      value: 1000
    }
  }

  let(:subject) { described_class.run!(item_params) }

  context 'when all attributes are present' do
    it 'creates item' do
      expect { subject }.to change { Item.count }.from(0).to(1)
    end

    context 'when name is too short' do
      let(:name) { 'a' }

      it 'does not create item' do
        expect { subject }.to raise_error(ActiveInteraction::InvalidInteractionError)
      end
    end
  end

  context 'when attribute is missing' do
    let(:item_params) {
      {
        customer: customer,
        name: nil,
        height: 5,
        length: 4,
        width: 5,
        weight: 100,
        value: 1000
      }
    }

    it 'does not create item' do
      expect{ subject }.to raise_error(ActiveInteraction::InvalidInteractionError)
    end
  end
end
