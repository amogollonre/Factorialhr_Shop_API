class CreateCarts < ActiveRecord::Migration[8.0]
  def change
    create_table :carts do |t|
      t.bigint :user_id, null: false
      t.string :status, limit: 50, null: false, default: 'pending'

      t.timestamps
    end
    add_index :carts, :user_id
    add_index :carts, :status
  end
end
