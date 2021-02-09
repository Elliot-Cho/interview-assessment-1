require 'rails_helper'

describe Customers::Create do
  let(:customer_params) {
    {
      name: 'new customer',
      charge_type: 0,
      charge_value: 1,
      flat_fee: 1
    }
  }

  let(:subject) { described_class.run!(customer_params) }

  context 'when all attributes are present' do
    it 'creates customer' do
      expect { subject }.to change { Customer.count }.from(0).to(1)
    end

    context 'when name is not unique' do
      before do
        Customer.create!(customer_params)
      end

      it 'does not create customer' do
        expect { subject }.to raise_error(ActiveInteraction::InvalidInteractionError)
      end
    end
  end

  context 'when attribute is missing' do
    let(:customer_params) {
      {
        charge_type: 0,
        charge_value: 1,
        flat_fee: 1
      }
    }

    it 'does not create customer' do
      expect{ subject }.to raise_error(ActiveInteraction::InvalidInteractionError)
    end
  end
end
