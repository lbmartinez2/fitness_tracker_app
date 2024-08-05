module Api
  class ExerciseController < ApplicationController
    def index
      exercise = Nutritionix::Client.exercise(params[:query])
    end
  end
end
