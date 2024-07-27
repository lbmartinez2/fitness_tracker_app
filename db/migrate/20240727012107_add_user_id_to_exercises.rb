class AddUserIdToExercises < ActiveRecord::Migration[7.1]
  def change
    add_reference :exercises, :user, null: false, foreign_key: true
  end
end
