class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.string :name, null: false
      t.float :flat_fee, null: false, default: 0
      t.integer :charge_type, null: false, default: 0
      t.float :charge_value, null: false, default: 0

      t.timestamps
    end
  end
end
