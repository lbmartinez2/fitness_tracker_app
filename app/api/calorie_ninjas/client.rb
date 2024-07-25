module CalorieNinjas
    class Client
        def self.nutrition_facts(query)
          response = Request.call('GET', "#{query}")
        end
    end
end