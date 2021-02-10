require 'rails_helper'

RSpec.describe Item, type: :model do
  let!(:customer) {
    Customer.create!(name: 'customer', charge_type: :volume, charge_value: 1, flat_fee: 1)
  }

  let(:item_params) {
    {
      customer: customer,
      name: 'box',
      height: 5,
      length: 4,
      width: 5,
      weight: 100,
      value: 1000
    }
  }

  let(:item) { Item.new(item_params) }

  describe 'create' do
    context 'when all attributes are present' do
      it 'can create item' do
        expect(item.save).to eq(true)
      end

      context 'when name too short' do
        let(:item_params) {
          {
            customer: customer,
            name: 'a',
            height: 5,
            length: 4,
            width: 5,
            weight: 100,
            value: 1000
          }
        }

        it 'cannot create item' do
          expect { item.save! }.to raise_error(ActiveRecord::RecordInvalid)
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

      it 'cannot create item' do
        expect { item.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe 'volume' do
    context 'when getting volume' do
      it 'should calculate volume correctly' do
        expect(item.volume).to eq(100)
      end
    end
  end
end

# == Schema Information
#
# Table name: items
#
#  id          :integer          not null, primary key
#  height      :float            not null
#  length      :float            not null
#  name        :string           not null
#  value       :float
#  weight      :float
#  width       :float            not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  customer_id :integer          not null
#
# Indexes
#
#  index_items_on_customer_id  (customer_id)
#
# Foreign Keys
#
#  customer_id  (customer_id => customers.id)
#
