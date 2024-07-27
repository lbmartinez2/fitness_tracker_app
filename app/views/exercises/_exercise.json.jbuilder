json.extract! exercise, :id, :date, :exercise_type, :duration, :calories_burnt, :created_at, :updated_at
json.url exercise_url(exercise, format: :json)
