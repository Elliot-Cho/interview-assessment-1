class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.string :name
      t.float :flat_fee
      t.integer :charge_type
      t.float :charge_value

      t.timestamps
    end
  end
end
