class CreateItems < ActiveRecord::Migration[8.0]
  def change
    create_table :items do |t|
      t.references :category, null: false, foreign_key: true
      t.string :name, null: false, limit: 100
      t.text :description
      t.decimal :base_price, precision: 10, scale: 2
      t.boolean :active, default: true

      t.timestamps
    end
    add_index :items, :name
  end
end
