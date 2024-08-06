class AddFoodNameToConsumptions < ActiveRecord::Migration[7.1]
  def change
    add_column :consumptions, :food_name, :string
  end
end
