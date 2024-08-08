# spec/models/exercise_spec.rb
require 'rails_helper'

RSpec.describe Exercise, type: :model do
  let(:user) { create(:user) }
  let(:exercise) { build(:exercise, user: user) }

  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(exercise).to be_valid
    end

    it 'is not valid without a user' do
      exercise.user = nil
      expect(exercise).to_not be_valid
    end

    it 'is not valid without a date' do
      exercise.date = nil
      expect(exercise).to_not be_valid
    end

    it 'is not valid without an exercise type' do
      exercise.exercise_type = nil
      expect(exercise).to_not be_valid
    end

    it 'is not valid without a duration' do
      exercise.duration = nil
      expect(exercise).to_not be_valid
    end

    it 'is not valid without calories burnt' do
      exercise.calories_burnt = nil
      expect(exercise).to_not be_valid
    end

    it 'is not valid with a negative duration' do
      exercise.duration = -5
      expect(exercise).to_not be_valid
    end

    it 'is not valid with a negative calorie count' do
      exercise.calories_burnt = -10
      expect(exercise).to_not be_valid
    end
  end
end
