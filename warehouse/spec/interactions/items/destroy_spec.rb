require 'rails_helper'

describe Items::Destroy do
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

  let(:subject) { described_class.run!(item: item) }

  context 'subject' do
    it 'should destroy the item' do
      expect { subject }.to change { Item.count }.from(1).to(0)
    end
  end
end
