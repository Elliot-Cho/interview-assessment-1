class CreateDiscounts < ActiveRecord::Migration[6.1]
  def change
    create_table :discounts do |t|
      t.float :percentage_off, null: false
      t.integer :item_coverage_from
      t.integer :item_coverage_to
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
