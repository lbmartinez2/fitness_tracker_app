class BmrAndAmrController < ApplicationController
  before_action :authenticate_user!

  def new
    @bmr = nil
    @amr = nil
  end

  def calculate
    weight = params[:current_weight] || current_user.current_weight || current_user.weight
    age = params[:age].to_f || current_user.age.to_f
    weight = weight.to_f
    height = current_user.height
    gender = params[:gender] || current_user.sex
    activity_level = params[:activity_level] || current_user.current_activity_level

    bmr = if gender == 'male'
            88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age)
          else
            447.593 + (9.247 * weight) + (3.096 * height) - (4.330 * age)
          end

    amr = case activity_level
          when 'Sedentary'
            bmr * 1.2
          when 'Low Active'
            bmr * 1.375
          when 'Moderately Active'
            bmr * 1.55
          when 'Active'
            bmr * 1.725
          when 'Very Active'
            bmr * 1.9
          else
            bmr
          end

    @bmr = bmr.round
    @amr = amr.round
  
    if current_user.update_without_password(current_weight: weight, bmr: @bmr, amr: @amr, age: age, current_activity_level: activity_level)
     
      current_user.reload
      respond_to do |format|
        format.html { render :new }
        format.json { render json: { bmr: @bmr, amr: @amr } }
      end
    else
 
      flash[:error] = "Failed to update user information."
      render :new
    end
  end
end
