class CreateExercises < ActiveRecord::Migration[7.1]
  def change
    create_table :exercises do |t|
      t.string :date
      t.string :type
      t.integer :duration
      t.integer :calories_burnt

      t.timestamps
    end
  end
end
