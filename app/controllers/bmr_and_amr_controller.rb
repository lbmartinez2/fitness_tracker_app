class BmrAndAmrController < ApplicationController
    before_action :authenticate_user!
  
    def new
      # Initialize BMR and AMR to nil to avoid errors when the form is initially loaded
      @bmr = nil
      @amr = nil
    end
  
    def calculate
      weight = current_user.weight
      height = current_user.height
      age = current_user.age
      gender = current_user.sex
      activity_level = current_user.current_activity_level
  
      # Calculate BMR
      @bmr = if gender == 'male'
               88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age)
             else
               447.593 + (9.247 * weight) + (3.096 * height) - (4.330 * age)
             end
  
      # Calculate AMR using switch-case for activity levels
      @amr = case activity_level
             when 'Sedentary'
               @bmr * 1.2
             when 'Low Active'
               @bmr * 1.375
             when 'Active'
               @bmr * 1.55
             when 'Very Active'
               @bmr * 1.725
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
  