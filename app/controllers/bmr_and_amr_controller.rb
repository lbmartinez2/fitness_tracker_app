class BmrAndAmrController < ApplicationController
    def new
      # This method can render a form to input the necessary data
    end
  
    def calculate
      weight = params[:weight].to_f
      height = params[:height].to_f
      age = params[:age].to_f
      gender = current_user.sex
      activity_level_factor = params[:activity_level_factor].to_f
  
      # Calculate BMR
      bmr = if gender == 'male'
              88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age)
            else
              447.593 + (9.247 * weight) + (3.096 * height) - (4.330 * age)
            end
  
      # Calculate AMR
      amr = bmr * activity_level_factor
  
      @result = { bmr: bmr, amr: amr }
  
      respond_to do |format|
        format.html { render :new } # Assuming you want to render the new form with the result
        format.json { render json: @result }
      end
    end
  end
  