class BmrAndAmrController < ApplicationController
  before_action :authenticate_user!

  def new
    @bmr = nil
    @amr = nil
  end

  def calculate
    weight = params[:current_weight] || current_user.current_weight || current_user.weight
    weight = weight.to_f
    height = current_user.height
    age = current_user.age
    gender = params[:gender] || current_user.sex
    activity_level = params[:activity_level] || current_user.current_activity_level
  
    Rails.logger.debug "Weight: #{weight}, Height: #{height}, Age: #{age}, Gender: #{gender}, Activity Level: #{activity_level}"
  
    # Calculate BMR
    bmr = if gender == 'male'
            88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age)
          else
            447.593 + (9.247 * weight) + (3.096 * height) - (4.330 * age)
          end
  
    Rails.logger.debug "Calculated BMR: #{bmr}"
  
    # Calculate AMR using switch-case for activity levels
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
            bmr # Default to BMR if activity level is not recognized
          end
  
    Rails.logger.debug "Calculated AMR: #{amr}"
  
    @bmr = bmr.round
    @amr = amr.round
  
    if current_user.update_without_password(current_weight: weight, bmr: @bmr, amr: @amr)
      Rails.logger.debug "User updated successfully: #{current_user.inspect}"
      current_user.reload
      respond_to do |format|
        format.html { render :new }
        format.json { render json: { bmr: @bmr, amr: @amr } }
      end
    else
      Rails.logger.debug "Failed to update user: #{current_user.errors.full_messages}"
      flash[:error] = "Failed to update user information."
      render :new
    end
  end
end
