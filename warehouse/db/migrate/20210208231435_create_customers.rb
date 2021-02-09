class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.string :name, null: false
      t.float :flat_fee, null: false
      t.integer :charge_type, null: false
      t.float :charge_value, null: false

      t.timestamps
    end
  end
end
