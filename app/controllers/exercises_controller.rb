class ExercisesController < ApplicationController
  before_action :authenticate_user!  
  before_action :set_exercise, only: %i[show edit update destroy]
  before_action :authorize_user!, only: %i[show edit update destroy]

  # GET /exercises or /exercises.json
  def index
    @searched_exercise = search_exercise(params[:q])
    @exercises = current_user.exercises.all  # Only show the exercises for the logged-in user
  end

  # GET /exercises/1 or /exercises/1.json
  def show
  end

  # GET /exercises/new
  def new
    @exercise = current_user.exercises.build

    if params[:searched_exercise].present?
      @searched_exercise = params[:searched_exercise]

      @exercise.attributes = {
        exercise_type: @searched_exercise["name"].titleize,
        duration: @searched_exercise["duration_min"],
        calories_burnt: @searched_exercise["nf_calories"]
      }
    else
      @searched_exercise = nil
    end
  end

  # GET /exercises/1/edit
  def edit
  end

  # POST /exercises or /exercises.json
  def create
    @exercise = current_user.exercises.build(exercise_params)

    respond_to do |format|
      if @exercise.save
        format.html { redirect_to exercise_url(@exercise), notice: "Exercise was successfully created." }
        format.json { render :show, status: :created, location: @exercise }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /exercises/1 or /exercises/1.json
  def update
    respond_to do |format|
      if @exercise.update(exercise_params)
        format.html { redirect_to exercise_url(@exercise), notice: "Exercise was successfully updated." }
        format.json { render :show, status: :ok, location: @exercise }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exercises/1 or /exercises/1.json
  def destroy
    @exercise.destroy!

    respond_to do |format|
      format.html { redirect_to exercises_url, notice: "Exercise was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_exercise
      @exercise = current_user.exercises.find(params[:id])  # Ensure the exercise belongs to the current user
    rescue ActiveRecord::RecordNotFound
      redirect_to exercises_path, alert: "Exercise not found."
    end

    # Only allow a list of trusted parameters through.
    def exercise_params
      params.require(:exercise).permit(:date, :exercise_type, :duration, :calories_burnt)
    end

    def search_exercise(name)
      data = Nutritionix::Client.exercise(name)
      data[:data].first[1] ? data[:data].first[1][0] : nil
    end

    
    def authorize_user!
      redirect_to exercises_path, alert: "You are not authorized to perform this action." unless @exercise.user == current_user
    end
end
