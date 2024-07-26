class AddDetailsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :name, :string
    add_column :users, :age, :integer
    add_column :users, :sex, :string
    add_column :users, :birthday, :date
    add_column :users, :height, :integer
    add_column :users, :weight, :integer
    add_column :users, :target_weight, :integer
    add_column :users, :target_date, :date
    add_column :users, :exercise_goals, :integer
    add_column :users, :current_activity_level, :string
    add_column :users, :full_time_job, :boolean
    add_column :users, :weight_loss_reason, :string
    add_column :users, :subscribe_to_updates, :boolean
  end
end
