class BmrAndAmrController < ApplicationController
    before_action :authenticate_user!
  
    def new
      # Initialize BMR and AMR to nil to avoid errors when the form is initially loaded
      @bmr = nil
      @amr = nil
    end
  
    def calculate
     # Update the user's weight in the database
      if current_user.update(weight: params[:weight])
      weight = current_user.weight
      height = current_user.height
      age = current_user.age
      gender = current_user.sex
      activity_level = current_user.current_activity_level
  
      # Calculate BMR
      bmr = if gender == 'male'
              88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age)
            else
              447.593 + (9.247 * weight) + (3.096 * height) - (4.330 * age)
            end
  

      # Calculate AMR
      amr = bmr * activity_level_factor

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

  
      @result = { bmr: bmr, amr: amr }
  
      respond_to do |format|
        format.html { render :new } # Assuming you want to render the new form with the result
        format.json { render json: @result }
      end
    end
  end
  