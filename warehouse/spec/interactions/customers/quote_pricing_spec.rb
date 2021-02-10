require 'rails_helper'

describe Customers::QuotePricing do
  let(:customer_params) {
    {
      name: 'new customer',
      charge_type: charge_type,
      charge_value: charge_value,
      flat_fee: flat_fee
    }
  }
  let(:charge_type) { :volume }
  let(:charge_value) { 1 }
  let(:flat_fee) { 0 }

  let!(:customer) { Customer.create!(customer_params) }

  let(:subject) { described_class.run!(customer: customer) }

  context 'when customer has items' do
    let!(:item1) {
      Item.create!(
        customer: customer,
        name: 'box',
        length: '2',
        width: '2',
        height: '2',
        weight: '10',
        value: '100'
      )
    }
    let!(:item2) {
      Item.create!(
        customer: customer,
        name: 'chair',
        length: '2',
        width: '2',
        height: '4',
        weight: '10',
        value: '500'
      )
    }

    context 'when customer is charged by volume' do
      let(:charge_type) { :volume }

      it 'calculates pricing by volume' do
        expect(subject).to eq(24)
      end

      context 'when customer has flat fee' do
        let(:flat_fee) { 20 }

        it 'calculates pricing by volume + flat fee' do
          expect(subject).to eq(44)
        end
      end
    end

    context 'when customer is charged by value' do
      let(:charge_type) { :value }
      let(:charge_value) { 10 }

      it 'calculates pricing by value' do
        expect(subject).to eq(60)
      end

      context 'wehn customer has flat fee' do
        let(:flat_fee) { 20 }

        it 'calculates pricing by value + flat fee' do
          expect(subject).to eq(80)
        end
      end
    end
  end

  context 'when customer has no items' do
    it 'fails validation' do
      expect { subject }.to raise_error(ActiveInteraction::InvalidInteractionError)
    end
  end
end
