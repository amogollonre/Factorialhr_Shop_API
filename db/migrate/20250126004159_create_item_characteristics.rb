class CreateItemCharacteristics < ActiveRecord::Migration[8.0]
  def change
    create_table :item_characteristics do |t|
      t.references :item, null: false, foreign_key: true
      t.references :characteristic, null: false, foreign_key: true
      t.references :characteristic_option, null: false, foreign_key: true
      t.boolean :active, default: true

      t.timestamps
    end
    add_index :item_characteristics, [:item_id, :characteristic_id], unique: true
  end
end
