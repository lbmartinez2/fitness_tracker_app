module CalorieNinjas
    class Request
        BASE_URL = "https://api.calorieninjas.com/v1/nutrition?query="
        TOKEN = ENV['API_KEY']

      def self.call(http_method, query = {})
        url = "#{BASE_URL}"
        url += "#{query.to_s}" unless query.empty?

        result = RestClient::Request.execute(
          method: http_method,
          url: url,
          headers: {'X-Api-Key' => TOKEN},
          contentType: 'application/json'
        )

        { code: result.code, status: 'Success', data: JSON.parse(result.body) }
      rescue RestClient::ExceptionWithResponse => error
        { code: error.http_code, status: error.message, data: Errors.map(error.http_code) }
      end
    end
  end