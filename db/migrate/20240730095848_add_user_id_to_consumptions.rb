class AddUserIdToConsumptions < ActiveRecord::Migration[7.1]
  def change
    add_column :consumptions, :user_id, :bigint, null: false
    add_foreign_key :consumptions, :users
    add_index :consumptions, :user_id
  end
end
