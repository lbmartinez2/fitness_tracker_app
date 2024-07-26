module Nutritionix
  class Client
      def self.exercise(query)
        response = Request.call('POST', query)
      end
  end
end