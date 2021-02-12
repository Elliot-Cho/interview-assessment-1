module CustomerHelper
  # Provide a pricing quote given a customer and a set of items
  class PriceQuoter
    def self.quote_pricing(customer, items)
      customer.flat_fee + calculate_pricing(customer, items)
    end

    def self.calculate_pricing(customer, items)
      send("pricing_by_#{customer.charge_type}", customer, items)
    end

    def self.pricing_by_volume(customer, items)
      items.each_with_index.map { |item, index|
        price = item.volume * customer.charge_value
        discount = price * (discount_percentage_for_item_index(customer, index + 1) / 100)

        price - discount
      }.sum
    end

    def self.pricing_by_value(customer, items)
      items.each_with_index.map { |item, index|
        price = item.value * (customer.charge_value / 100)
        discount = price * (discount_percentage_for_item_index(customer, index + 1) / 100)

        price - discount
      }.sum
    end

    def self.discount_percentage_for_item_index(customer, index)
      discount = customer.discounts.find_by(
        'item_coverage_from <= ? AND (item_coverage_to IS NULL OR item_coverage_to >= ?)',
        index,
        index
      )

      discount ? discount.percentage_off : 0
    end
  end
end
