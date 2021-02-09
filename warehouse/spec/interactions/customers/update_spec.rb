require 'rails_helper'

describe Customers::Update do
  let!(:customer) {
    Customer.create!(
      name: 'customer',
      charge_type: 0,
      charge_value: 1,
      flat_fee: 1
    )
  }

  let(:customer_params) {
    {
      name: 'updated customer',
      charge_type: 1,
      charge_value: 2,
      flat_fee: 2
    }
  }

  let(:subject) { described_class.run!(customer_params.merge!(customer: customer)) }

  context 'when all attributes are present' do
    it 'updates customer' do
      subject

      expect(customer.reload.name).to eq('updated customer')
      expect(customer.reload.charge_type).to eq('value')
      expect(customer.reload.charge_value).to eq(2)
      expect(customer.reload.flat_fee).to eq(2)
    end

    context 'when name is not unique' do
      before do
        Customer.create!(customer_params)
      end

      it 'does not update customer' do
        expect { subject }.to raise_error(ActiveInteraction::InvalidInteractionError)
      end
    end
  end

  context 'when attribute is missing' do
    let(:customer_params) {
      {
        charge_type: 1,
        charge_value: 2,
        flat_fee: 2
      }
    }

    it 'does not update customer' do
      expect { subject }.to raise_error(ActiveInteraction::InvalidInteractionError)
    end
  end
end
