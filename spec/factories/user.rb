FactoryBot.define do
    factory :user do
      name { "Anstley Noel Obras" }
      email { "anp.obras@fitnesspal.com" }
      password { "123456" }
      password_confirmation { "123456" }
  
      # Add any additional user attributes here
      # For example, if you have bmr and amr attributes
    #   bmr { 1776 }
    #   amr { 3063 }
      activity_level { 'active' }
    end
end
  