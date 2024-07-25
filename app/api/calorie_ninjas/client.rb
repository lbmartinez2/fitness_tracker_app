module CalorieNinjas
    class Client
        def self.nutrition_facts
          response = Request.call('GET', "orange juice")
        end
    end
end