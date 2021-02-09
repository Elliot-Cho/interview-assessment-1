require 'rails_helper'

RSpec.describe Customer, type: :model do
  let(:customer_params) {
    {
      name: 'asdf',
      charge_type: :volume,
      charge_value: 1,
      flat_fee: 1
    }
  }

  let(:customer) { Customer.new(customer_params) }

  context 'when all attributes are present' do
    it 'can create customer' do
      expect(customer.save).to eq(true)
    end

    context 'when name is not unique' do
      before do
        Customer.create!(customer_params)
      end

      it 'cannot create customer' do
        expect { customer.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  context 'when attribute is missing' do
    let(:customer_params) {
      {
        charge_type: :volume,
        charge_value: 1,
        flat_fee: 1
      }
    }

    it 'cannot create customer' do
      expect { customer.save! }.to raise_error(ActiveRecord::NotNullViolation)
    end
  end
end

# == Schema Information
#
# Table name: customers
#
#  id           :integer          not null, primary key
#  charge_type  :integer          default("volume"), not null
#  charge_value :float            default(0.0), not null
#  flat_fee     :float            default(0.0), not null
#  name         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
