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
  end
end
