class AddDetailsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :age, :integer unless column_exists?(:users, :age)
    add_column :users, :sex, :string unless column_exists?(:users, :sex)
    add_column :users, :birthday, :date unless column_exists?(:users, :birthday)
    add_column :users, :height, :integer unless column_exists?(:users, :height)
    add_column :users, :weight, :integer unless column_exists?(:users, :weight)
    add_column :users, :target_weight, :integer unless column_exists?(:users, :target_weight)
    add_column :users, :target_date, :date unless column_exists?(:users, :target_date)
    add_column :users, :exercise_goals, :integer unless column_exists?(:users, :exercise_goals)
    add_column :users, :current_activity_level, :string unless column_exists?(:users, :current_activity_level)
    add_column :users, :full_time_job, :boolean unless column_exists?(:users, :full_time_job)
    add_column :users, :weight_loss_reason, :string unless column_exists?(:users, :weight_loss_reason)
    add_column :users, :subscribe_to_updates, :boolean unless column_exists?(:users, :subscribe_to_updates)
  end
end
