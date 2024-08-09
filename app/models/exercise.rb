class Exercise < ApplicationRecord
  belongs_to :user
  validates :user, presence: true
  validates :date, presence: true
  validates :exercise_type, presence: true
  validates :duration, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :calories_burnt, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
