class RenameTypeToExerciseTypeInExercises < ActiveRecord::Migration[7.1]
  def change
    rename_column :exercises, :type, :exercise_type
  end
end
