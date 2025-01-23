class CreateCategoryOptionRestrictions < ActiveRecord::Migration[8.0]
  def change
    create_table :category_option_restrictions do |t|
      t.references :category, null: false, foreign_key: true
      t.references :if_characteristic_option, null: false, foreign_key: { to_table: :characteristic_options }
      t.references :then_characteristic_option, null: false, foreign_key: { to_table: :characteristic_options }
      t.string :restriction_type, limit: 50
      t.boolean :active, default: true
      t.timestamps
     end
     add_index :category_option_restrictions, [:category_id, :if_characteristic_option_id, :then_characteristic_option_id], unique: true, name: 'idx_category_option_restrictions_unique'
  end
end
