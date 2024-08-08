json.extract! exercise, :id, :date, :food_name, :meal_type, :macros, :calories, :created_at, :updated_at
json.url consumption_url(consumption, format: :json)

from params