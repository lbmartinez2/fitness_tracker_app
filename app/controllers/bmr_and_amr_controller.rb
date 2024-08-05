# app/controllers/bmr_and_amr_controller.rb
class BmrAndAmrController < ApplicationController
    def new
      # Logic for new form, if needed
    end
  
    def calculate
      weight = params[:weight].to_f
      height = params[:height].to_f
      age = params[:age].to_f
      gender = params[:gender]
      activity_level = params[:activity_level]
  
      # Calculate BMR
      @bmr = if gender == 'male'
               88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age)
             else
               447.593 + (9.247 * weight) + (3.096 * height) - (4.330 * age)
             end
  
      # Calculate AMR using switch-case for activity levels
      @amr = case activity_level
             when 'sedentary'
               @bmr * 1.2
             when 'lightly_active'
               @bmr * 1.375
             when 'moderately_active'
               @bmr * 1.55
             when 'active'
               @bmr * 1.725
             when 'extremely_active'
               @bmr * 1.9
             else
               @bmr # Default to BMR if activity level is not recognized
             end
  
      respond_to do |format|
        format.html { render :new }
        format.json { render json: { bmr: @bmr, amr: @amr } }
      end
    end
  
    def show
      @bmr = params[:bmr].to_f
      @calories_today = params[:calories_today].to_f
      @glasses_of_water = params[:glasses_of_water].to_i
  
      @water_message = if @glasses_of_water >= 8
                         "Good job! You've reached the standard water intake for the day."
                       else
                         "Standard water intake is 8 glasses. Keep hydrating!"
                       end
  
      @calorie_status = calculate_calorie_status(@calories_today, @bmr)
    end
  
    private
  
    def calculate_calorie_status(calories_today, bmr)
      if calories_today > bmr + 150
        { message: "Exceeded", color: "red" }
      elsif calories_today.between?(bmr + 100, bmr + 150)
        { message: "About 100+", color: "yellow" }
      elsif calories_today <= bmr
        { message: "Goal has been reached", color: "green" }
      else
        { message: "Below the goal", color: "green" }
      end
    end
  end
  