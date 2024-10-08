class PortfolioController < ActionController::Base
  before_action :authenticate_user!
  
  layout "application"
  def index
    @exercises = current_user.exercises
    @consumptions = current_user.consumptions
    @start_date = current_user.created_at.to_date.strftime('%B %d, %Y')
    @total_exercises_count = @exercises.count
    @total_calories = @consumptions.sum(&:calories)

  end

  def daily
      selected_date = params[:date].present? ? Date.parse(params[:date]) : Date.today
      # @amr = current_user.amr
      # @bmr = current_user.bmr
      @consumptions = current_user.consumptions.where(date: selected_date)
  
      @macros_data = @consumptions.each_with_object(Hash.new(0)) do |consumption, hash|
        next unless consumption.macros.present?
        macros = JSON.parse(consumption.macros)
        macros.except('serving_size_g', 'calories').each do |key, value|
          formatted_key = key.gsub('_', ' ').capitalize
   
          if value.is_a?(Numeric)
            if formatted_key.include?('mg')
              hash[formatted_key.gsub('mg', 'g')] += value.to_f / 1000
            else
              hash[formatted_key] += value.to_f
            end
          end
        end
      end

      @date_range = (Date.today.beginning_of_month..Date.today.end_of_month).to_a
      @total_calories = @consumptions.sum(&:calories)
      exercises = current_user.exercises.where("DATE(date) = ?", selected_date.to_s)
      @total_exercise_calories = exercises.sum(&:calories_burnt)
      @amr = current_user.amr || 0
      @bmr = current_user.bmr || 0
      @calorie_deficit = @amr - @total_calories + @total_exercise_calories || 0
  end

  def weekly

    selected_week_start = params[:week_start].present? ? Date.parse(params[:week_start]) : Date.today.beginning_of_week(:sunday)
    selected_week_end = selected_week_start.end_of_week(:saturday)

    week_dates = (selected_week_start..selected_week_end).map { |date| [date.strftime('%a'), 0] }.to_h
    @date_range = (selected_week_start..selected_week_end).to_a
    actual_data = current_user.consumptions.where(date: selected_week_start..selected_week_end)
                                       .group_by { |c| c.date.strftime('%a') }
                                       .transform_values { |consumptions| consumptions.sum(&:calories) }

    @consumptions_data = week_dates.merge(actual_data)

    @amr = current_user.amr || 0
    @bmr = current_user.bmr || 0

  end
end

