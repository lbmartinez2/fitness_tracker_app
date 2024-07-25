module Api
  class NutritionFactsController < ApplicationController
    def index
      nutrition_facts = CalorieNinjas::Client.nutrition_facts
      render json: nutrition_facts
    end
  end
end