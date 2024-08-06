class AddDetailsToConsumptions < ActiveRecord::Migration[7.1]
  def change
    add_column :consumptions, :date, :date
    add_column :consumptions, :meal_type, :string
    add_column :consumptions, :calories, :float
    add_column :consumptions, :macros, :json
  end
end
