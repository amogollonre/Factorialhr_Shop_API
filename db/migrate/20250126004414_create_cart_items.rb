class CreateCartItems < ActiveRecord::Migration[8.0]
  def change
    create_table :cart_items do |t|
      t.references :cart, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.jsonb :selected_options, null: false, default: {}
      t.decimal :final_price, precision: 10, scale: 2, null: false

      t.timestamps
    end
    add_index :cart_items, [:cart_id, :item_id], unique: true
  end
end
