require 'rails_helper'

RSpec.describe BmrAndAmrController, type: :controller do
  let(:user) { create(:user, age: 30, height: 170, weight: 70, sex: 'male', current_activity_level: 'Moderately Active') }

  before do
    sign_in user
  end

  describe "POST #calculate" do
    it "calculates and updates BMR and AMR" do
      post :calculate, params: { current_weight: 75, gender: 'male', activity_level: 'Moderately Active' }
      
      user.reload
      expect(user.bmr).to be_present
      expect(user.amr).to be_present
    end
  end
end
