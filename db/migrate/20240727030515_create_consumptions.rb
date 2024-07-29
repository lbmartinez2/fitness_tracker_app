class CreateConsumptions < ActiveRecord::Migration[7.1]
  def change
    create_table :consumptions do |t|

      t.timestamps
    end
  end
end
