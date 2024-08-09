user = User.create!(
  email: 'testuser@example.com',
  password: 'password123',
  age: 30,
  sex: 'male',
  birthday: '1994-05-15',
  height: 175,
  weight: 70,
  target_weight: 65,
  target_date: '2024-12-31',
  exercise_goals: 3,
  current_activity_level: 'moderate',
  full_time_job: true,
  weight_loss_reason: 'health',
  subscribe_to_updates: true,
  name: 'Test User',
  current_weight: 70.0,
  amr: 2500.0,
  bmr: 1800.0
)

start_date = Date.today - 10
dates = (0..9).map { |i| start_date + i }


exercise_types = ['Running', 'Cycling', 'Swimming', 'Yoga', 'Weightlifting']


macros = [
  { "name": "eggs", "calories": 360.8, "serving_size_g": 250.0, "fat_total_g": 23.4, "fat_saturated_g": 7.8, "protein_g": 31.5, "sodium_mg": 359, "potassium_mg": 500, "cholesterol_mg": 933, "carbohydrates_total_g": 1.8, "fiber_g": 0.0, "sugar_g": 0.9 }.to_json,
  { "name": "chicken breast", "calories": 165.0, "serving_size_g": 100.0, "fat_total_g": 3.6, "fat_saturated_g": 1.0, "protein_g": 31.0, "sodium_mg": 74, "potassium_mg": 256, "cholesterol_mg": 85, "carbohydrates_total_g": 0.0, "fiber_g": 0.0, "sugar_g": 0.0 }.to_json
]


dates.each_with_index do |date, index|
  Exercise.create!(
    user: user,
    date: date,
    exercise_type: exercise_types[index % exercise_types.length],
    duration: rand(30..60),
    calories_burnt: rand(200..500)
  )
end


dates.each_with_index do |date, index|
  3.times do
    Consumption.create!(
      user: user,
      date: date,
      meal_type: ['Breakfast', 'Lunch', 'Dinner'].sample,
      calories: rand(200..800),
      macros: macros.sample,
      food_name: ['eggs', 'chicken breast', 'broccoli', 'rice', 'salmon'].sample
    )
  end
end
