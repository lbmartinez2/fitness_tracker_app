module Api
  class NutritionFactsController < ApplicationController
    def index
      nutrition_facts = CalorieNinjas::Client.nutrition_facts(params[:query])
      render json: nutrition_facts[:data].first[1].map { |item| item }
    end

    #   BMR Calculations
    #     Male
    #       88.362 + 13.397*weight(kg) + 4.799*height(cm) - 5.677*age
    #     Female
    #       447.593 + 9.247*weight(kg) + 3.096*height(cm) - 4.330*age
  end
end