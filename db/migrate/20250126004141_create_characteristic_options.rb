class CreateCharacteristicOptions < ActiveRecord::Migration[8.0]
  def change
    create_table :characteristic_options do |t|
      t.references :characteristic, null: false, foreign_key: true
      t.string :name, null: false, limit: 100
      t.text :description
      t.decimal :price_adjustment, precision: 10, scale: 2, default: 0.0
      t.boolean :in_stock, default: true

      t.timestamps
    end
    add_index :characteristic_options, [:characteristic_id, :name], unique: true
  end
end
