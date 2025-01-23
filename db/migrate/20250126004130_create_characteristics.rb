class CreateCharacteristics < ActiveRecord::Migration[8.0]
  def change
    create_table :characteristics do |t|
      t.references :category, null: false, foreign_key: true
      t.string :name, null: false, limit: 100
      t.text :description
      t.boolean :required, default: false
      t.boolean :active, default: true

      t.timestamps
    end
    add_index :characteristics, [:category_id, :name], unique: true
  end
end
