# spec/models/consumption_spec.rb
require 'rails_helper'

RSpec.describe Consumption, type: :model do
  let(:user) { User.create(email: 'test@example.com', password: 'password123') }
  let(:valid_attributes) do
    { user: user, food_name: 'Apple', date: Date.today, calories: 95 }
  end

  let(:consumption) { Consumption.new(valid_attributes) }

  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(consumption).to be_valid
    end

    it 'is not valid without a user' do
      consumption.user = nil
      expect(consumption).to_not be_valid
      puts consumption.errors.full_messages # Debug output
    end

    it 'is not valid without a food name' do
      consumption.food_name = nil
      expect(consumption).to_not be_valid
      puts consumption.errors.full_messages # Debug output
    end

    it 'is not valid without a date' do
      consumption.date = nil
      expect(consumption).to_not be_valid
      puts consumption.errors.full_messages # Debug output
    end

    it 'is not valid without calories' do
      consumption.calories = nil
      expect(consumption).to_not be_valid
      puts consumption.errors.full_messages # Debug output
    end

    it 'is not valid with a negative calorie count' do
      consumption.calories = -100
      expect(consumption).to_not be_valid
      puts consumption.errors.full_messages # Debug output
    end
  end
end
