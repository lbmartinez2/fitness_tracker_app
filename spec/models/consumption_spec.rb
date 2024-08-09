class Consumption < ApplicationRecord
    belongs_to :user
  
    validates :food_name, presence: true
    validates :date, presence: true
    validates :calories, numericality: { greater_than_or_equal_to: 0 }
  
    def self.total_calories_for_day(date)
      where("DATE(created_at) = ?", date).sum(:calories)
    end
  
    def self.water_intake_status(user_id, date)
      water_glasses = where(user_id: user_id)
                        .where("DATE(created_at) = ?", date.to_date)
                        .sum(:water_glasses)
      water_glasses >= 8 ? "Goal met" : "Goal not met"
    end
  
    def self.calorie_goal_status(user, date)
      total_calories = total_calories_for_day(date)
      bmr = user.calculate_bmr
      amr = user.calculate_amr(user.activity_level)# spec/models/consumption_spec.rb

      require 'rails_helper'
      
      RSpec.describe Consumption, type: :model do
        let(:user) { FactoryBot.create(:user) }
        let(:consumption) { FactoryBot.build(:consumption, user: user) }
      
        describe 'validations' do
          it 'is valid with valid attributes' do
            expect(consumption).to be_valid
          end
      
          it 'is not valid without a food_name' do
            consumption.food_name = nil
            expect(consumption).not_to be_valid
          end
      
          it 'is not valid without a date' do
            consumption.date = nil
            expect(consumption).not_to be_valid
          end
      
          it 'is not valid with a negative calories value' do
            consumption.calories = -1
            expect(consumption).not_to be_valid
          end
        end
      
        describe 'class methods' do
          before do
            FactoryBot.create(:consumption, user: user, date: Date.today, calories: 500, water_glasses: 10)
            FactoryBot.create(:consumption, user: user, date: Date.today, calories: 200)
          end
      
          describe '.total_calories_for_day' do
            it 'returns the total calories for a given day' do
              expect(Consumption.total_calories_for_day(Date.today)).to eq(700)
            end
          end
      
          describe '.water_intake_status' do
            it 'returns "Goal met" if water intake is 8 or more glasses' do
              expect(Consumption.water_intake_status(user.id, Date.today)).to eq("Goal met")
            end
      
            it 'returns "Goal not met" if water intake is less than 8 glasses' do
              FactoryBot.create(:consumption, user: user, date: Date.today, water_glasses: 5)
              expect(Consumption.water_intake_status(user.id, Date.today)).to eq("Goal not met")
            end
          end
      
          describe '.calorie_goal_status' do
            let(:user_with_calculations) do
              FactoryBot.create(:user, bmr: 1500, amr: 2000, activity_level: 'moderate')
            end
      
            it 'returns "Exceeded" if total calories exceed AMR by more than 150' do
              FactoryBot.create(:consumption, user: user_with_calculations, date: Date.today, calories: 2200)
              expect(Consumption.calorie_goal_status(user_with_calculations, Date.today)).to eq("Exceeded")
            end
      
            it 'returns "Goal has been reached" if total calories are within the range of BMR and AMR' do
              FactoryBot.create(:consumption, user: user_with_calculations, date: Date.today, calories: 1800)
              expect(Consumption.calorie_goal_status(user_with_calculations, Date.today)).to eq("Goal has been reached")
            end
      
            it 'returns "About 100+" if total calories are within 100+ of AMR' do
              FactoryBot.create(:consumption, user: user_with_calculations, date: Date.today, calories: 2100)
              expect(Consumption.calorie_goal_status(user_with_calculations, Date.today)).to eq("About 100+")
            end
      
            it 'returns "Below goal" if total calories are below the BMR' do
              FactoryBot.create(:consumption, user: user_with_calculations, date: Date.today, calories: 1400)
              expect(Consumption.calorie_goal_status(user_with_calculations, Date.today)).to eq("Below goal")
            end
          end
        end
      end
      
  
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
  