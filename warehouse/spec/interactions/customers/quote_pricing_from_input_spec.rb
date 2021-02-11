require 'rails_helper'

describe Customers::QuotePricingFromInput do
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

  let(:params) {
    {
      customer: customer,
      input: '{"items": [{"name": "Fridge", "length": "3", "height": "6", "width": "4", "weight": "300",' \
        '"value": "1000"}, {"name": "Sofa", "length": "6", "height": "4", "width": "3", "weight": "100",' \
        '"value": "500"}]}'
    }
  }

  let(:subject) { described_class.run!(params) }

  context 'with valid input' do
    context 'when customer is charged by volume' do
      let(:charge_type) { :volume }

      it 'calculates pricing by volume' do
        expect(subject).to eq(144)
      end

      context 'when customer has flat fee' do
        let(:flat_fee) { 20 }

        it 'calculates pricing by volume + flat fee' do
          expect(subject).to eq(164)
        end
      end
    end

    context 'when customer is charged by value' do
      let(:charge_type) { :value }
      let(:charge_value) { 10 }

      it 'calculates pricing by value' do
        expect(subject).to eq(150)
      end

      context 'wehn customer has flat fee' do
        let(:flat_fee) { 20 }

        it 'calculates pricing by value + flat fee' do
          expect(subject).to eq(170)
        end
      end
    end

    context 'when customer has discounts' do
      let!(:discount1) {
        Discount.create!(
          customer: customer,
          percentage_off: 5,
          item_coverage_from: 0,
          item_coverage_to: 1
        )
      }

      let!(:discount2) {
        Discount.create!(
          customer: customer,
          percentage_off: 10,
          item_coverage_from: 2
        )
      }

      context 'when customer is charged by volume' do
        let(:charge_type) { :volume }

        it 'calculates pricing by volume & applies discount' do
          expect(subject).to eq(133.2)
        end

        context 'when customer has flat fee' do
          let(:flat_fee) { 20 }

          it 'calculates pricing by volume with discount + flat fee' do
            expect(subject).to eq(153.2)
          end
        end
      end

      context 'when customer is charged by value' do
        let(:charge_type) { :value }
        let(:charge_value) { 10 }

        it 'calculates pricing by value and applies discount' do
          expect(subject).to eq(140)
        end

        context 'wehn customer has flat fee' do
          let(:flat_fee) { 20 }

          it 'calculates pricing by value with discount + flat fee' do
            expect(subject).to eq(160)
          end
        end
      end
    end
  end

  context 'when input is not valid json' do
    let(:params) {
      {
        customer: customer,
        input: 'invalid'
      }
    }

    it 'fails validation' do
      expect { subject }.to raise_error(ActiveInteraction::InvalidInteractionError)
    end
  end

  context 'when input contains an invalid item' do
    let(:params) {
      {
        customer: customer,
        input: '{"items": [{"name": "Fridge", "weight": "300",' \
          '"value": "1000"}, {"name": "Sofa", "length": "6", "height": "4", "width": "3", "weight": "100",' \
          '"value": "500"}]}'
      }
    }

    it 'fails validation' do
      expect { subject }.to raise_error(ActiveInteraction::InvalidInteractionError)
    end
  end
end
