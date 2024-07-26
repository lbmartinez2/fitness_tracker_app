class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
  
    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :age, :sex, :birthday, :height, :weight, :target_weight, :target_date, :exercise_goals, :current_activity_level, :full_time_job, :weight_loss_reason, :subscribe_to_updates])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :age, :sex, :birthday, :height, :weight, :target_weight, :target_date, :exercise_goals, :current_activity_level, :full_time_job, :weight_loss_reason, :subscribe_to_updates])
    end
end
  