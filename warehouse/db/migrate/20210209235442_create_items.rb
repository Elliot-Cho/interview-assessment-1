class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.float :length, null: false
      t.float :width, null: false
      t.float :height, null: false
      t.float :weight
      t.float :value
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
