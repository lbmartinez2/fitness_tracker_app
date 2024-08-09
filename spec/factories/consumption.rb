FactoryBot.define do
    factory :consumption do
      food_name { "Apple" }
      date { Date.today }
      calories { 100 }
      water_glasses { 8 } # Adjust if you have a different attribute for water intake
  
      association :user
    end
end