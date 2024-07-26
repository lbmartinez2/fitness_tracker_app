module Api
  class NutritionFactsController < ApplicationController
    def index
      nutrition_facts = CalorieNinjas::Client.nutrition_facts(params[:query])
      render json: nutrition_facts[:data]
      #.first[1].map { |item| item["name"] }
    end

    #   BMR Calculations
    #     Male
    #       88.362 + 13.397*weight(kg) + 4.799*height(cm) - 5.677*age
    #     Female
    #       447.593 + 9.247*weight(kg) + 3.096*height(cm) - 4.330*age
    
    #       Sedentary (little or no exercise): AMR = BMR x 1.2.
    #       Lightly active (exercise 1–3 days/week): AMR = BMR x 1.375.
    #       Moderately active (exercise 3–5 days/week): AMR = BMR x 1.55.
    #       Active (exercise 6–7 days/week): AMR = BMR x 1.725.
    #       Extremely active (hard exercise 6–7 days/week): AMR = BMR x 1.9.
  end
end