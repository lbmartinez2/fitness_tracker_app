class ConsumptionsController < ApplicationController
  before_action :authenticate_user! 
  before_action :set_consumption, only: %i[ show edit update destroy ]
  before_action :authorize_user!, only: %i[ show edit update destroy ]

  # GET /consumptions or /consumptions.json
  def index
    @consumptions = current_user.consumptions
    @searched_consumptions = search_consumption(params[:q])
  end

  # GET /consumptions/1 or /consumptions/1.json
  def show
  end

  # GET /consumptions/new
  def new
    @consumption = current_user.consumptions.build

    if params[:searched_consumption].present?
      @searched_consumption = JSON.parse(params[:searched_consumption])
      @consumption.attributes = {
        food_name: @searched_consumption["name"].titleize,
        date: Date.today,
        meal_type: "Lunch", # Change this to your desired default meal type
        calories: @searched_consumption["calories"],
        macros: @searched_consumption.to_json
      }
    else
      @searched_consumption = nil
    end
  end

  # GET /consumptions/1/edit
  def edit
  end

  # POST /consumptions or /consumptions.json
  def create
    @consumption = current_user.consumptions.build(consumption_params)
    Rails.logger.debug "Consumption params: #{consumption_params.inspect}"
    respond_to do |format|
      if @consumption.save
        format.html { redirect_to consumption_url(@consumption), notice: "Consumption was successfully created." }
        format.json { render :show, status: :created, location: @consumption }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @consumption.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /consumptions/1 or /consumptions/1.json
  def update
    respond_to do |format|
      if @consumption.update(consumption_params)
        format.html { redirect_to consumption_url(@consumption), notice: "Consumption was successfully updated." }
        format.json { render :show, status: :ok, location: @consumption }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @consumption.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /consumptions/1 or /consumptions/1.json
  def destroy
    @consumption.destroy!

    respond_to do |format|
      format.html { redirect_to consumptions_url, notice: "Consumption was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_consumption
    @consumption = current_user.consumptions.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def consumption_params
    params.require(:consumption).permit(:date, :meal_type, :calories, :food_name, :macros)
  end

  def portfolio
    @date = Date.today
    @total_calories = Consumption.total_calories_for_day(@date)
    @water_intake_status = Consumption.water_intake_status(current_user.id, @date)
    @calorie_goal_status = Consumption.calorie_goal_status(current_user, @date)

    respond_to do |format|
      format.html
      format.json { render json: { total_calories: @total_calories, water_intake_status: @water_intake_status, calorie_goal_status: @calorie_goal_status } }
    end
  end
  
  def search_consumption(name)
    data = CalorieNinjas::Client.nutrition_facts(name)
    data[:data]["items"]
  end

  
  def authorize_user!
    redirect_to consumptions_path, alert: "You are not authorized to perform this action." unless @consumption.user == current_user
  end
end
