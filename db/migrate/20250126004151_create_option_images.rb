class CreateOptionImages < ActiveRecord::Migration[8.0]
  def change
    create_table :option_images do |t|
      t.references :characteristic_option, null: false, foreign_key: true
      t.string :url, null: false, limit: 255
      t.string :alt_text, limit: 255
      t.boolean :is_main, default: false
      t.integer :display_order

      t.timestamps
    end
    add_index :option_images, [:characteristic_option_id, :display_order], unique: true, name: 'index_option_images_on_char_opt_id_and_display_order'
  end
end