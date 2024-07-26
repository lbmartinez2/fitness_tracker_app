module Api
  class ExerciseController < ApplicationController
    def index
      exercise = Nutritionix::Client.exercise(params[:query])
      render json: exercise[:data]["exercises"]
    end
  end
end
