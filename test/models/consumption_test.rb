require 'rails_helper'

RSpec.describe Consumption, type: :model do
  let(:consumption) { build(:consumption) }

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

  describe '.total_calories_for_day' do
    it 'calculates total calories for a specific day' do
      user = create(:user)
      create(:consumption, user: user, date: Date.today, calories: 500)
      create(:consumption, user: user, date: Date.today, calories: 300)
      
      expect(Consumption.total_calories_for_day(Date.today)).to eq(800)
    end
  end
end
