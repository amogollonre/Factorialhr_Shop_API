class CreateItemImages < ActiveRecord::Migration[8.0]
  def change
    create_table :item_images do |t|
      t.references :item, null: false, foreign_key: true
      t.string :url, null: false, limit: 255
      t.string :alt_text, limit: 255
      t.boolean :is_main, default: false
      t.integer :display_order

      t.timestamps
    end
    add_index :item_images, [:item_id, :display_order], unique: true
  end
end
