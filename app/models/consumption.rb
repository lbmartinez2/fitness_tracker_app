class Consumption < ApplicationRecord
  belongs_to :user

  validates :food_name, presence: true
  validates :date, presence: true
  validates :calories, numericality: { greater_than_or_equal_to: 0 }

  def self.total_calories_for_day(date)
    where("DATE(created_at) = ?", date).sum(:calories)
  end

  def self.water_intake_status(user_id, date)
    # Assuming there's a `water_glasses` column to track daily water intake
    water_glasses = where(user_id: user_id)
                      .where("DATE(created_at) = ?", date)
                      .sum(:water_glasses)
    water_glasses >= 8 ? "Goal met" : "Goal not met"
  end

  def self.calorie_goal_status(user, date)
    total_calories = total_calories_for_day(date)
    bmr = user.calculate_bmr
    amr = user.calculate_amr(user.activity_level)

    if total_calories > amr + 150
      "Exceeded"
    elsif total_calories >= bmr && total_calories <= amr
      "Goal has been reached"
    elsif total_calories >= bmr + 100 && total_calories <= amr + 100
      "About 100+"
    else
      "Below goal"
    end
  end
end
