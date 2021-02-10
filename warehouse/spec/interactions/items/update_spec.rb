require 'rails_helper'

describe Items::Update do
  let!(:customer) {
    Customer.create!(name: 'customer', charge_type: :volume, charge_value: 1, flat_fee: 1)
  }

  let!(:item) {
    Item.create!(
      customer: customer,
      name: 'box',
      height: 5,
      length: 4,
      width: 5,
      weight: 100,
      value: 1000
    )
  }

  let(:new_name) { 'couch' }

  let(:item_params) {
    {
      customer: customer,
      name: new_name,
      height: 3,
      length: 10,
      width: 5,
      weight: 300,
      value: 1500
    }
  }

  let(:subject) { described_class.run!(item_params.merge!(item: item)) }

  context 'when all attributes are present' do
    it 'updates item' do
      subject

      expect(item.reload.name).to eq('couch')
      expect(item.reload.height).to eq(3)
      expect(item.reload.length).to eq(10)
      expect(item.reload.width).to eq(5)
      expect(item.reload.weight).to eq(300)
      expect(item.reload.value).to eq(1500)
    end

    context 'when name is too short' do
      let(:new_name) { 'a' }

      it 'does not update item' do
        expect { subject }.to raise_error(ActiveInteraction::InvalidInteractionError)
      end
    end
  end

  context 'when attribute is missing' do
    let(:customer_params) {
      {
        customer: customer,
        name: nil,
        height: 3,
        length: 10,
        width: 5,
        weight: 300,
        value: 1500
      }
    }

    it 'does not update item' do
      expect { subject }.to raise_error(ActiveInteraction::InvalidInteractionError)
    end
  end
end
