class AddFieldsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :current_weight, :float
    add_column :users, :amr, :float
    add_column :users, :bmr, :float
  end
end
