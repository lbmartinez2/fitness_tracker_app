class ChangeDateColumnTypeInExercises < ActiveRecord::Migration[7.1]
  def up
    change_column :exercises, :date, :date, using: 'date::date'
  end

  def down
    change_column :exercises, :date, :string
  end
end
