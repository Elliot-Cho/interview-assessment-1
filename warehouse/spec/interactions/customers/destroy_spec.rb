require 'rails_helper'

describe Customers::Destroy do
  let!(:customer) {
    Customer.create!(
      name: 'customer',
      charge_type: 0,
      charge_value: 1,
      flat_fee: 1
    )
  }

  let(:subject) { described_class.run!(customer: customer) }

  context 'subject' do
    it 'should destroy the customer' do
      expect { subject }.to change { Customer.count }.from(1).to(0)
    end

    context 'customer has item' do
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

      it 'should also destroy item' do
        expect { subject }.to change { Item.count }.from(1).to(0)
      end
    end
  end
end
