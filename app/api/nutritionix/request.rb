module Nutritionix
  class Request
    BASE_URL = "https://trackapi.nutritionix.com/v2/natural/exercise"
    TOKEN = ENV['APP_KEY']
    APP_ID = ENV['APP_ID']

    def self.call(http_method, query = {})
      url = BASE_URL

      result = RestClient::Request.execute(
        method: http_method,
        url: url,
        headers: {
          'x-app-id': APP_ID,
          'x-app-key': TOKEN,
          'Content-Type': 'application/json'
        },
        payload: { query: query }.to_json
      )

      { code: result.code, status: 'Success', data: JSON.parse(result.body) }
    rescue RestClient::ExceptionWithResponse => error
      { code: error.http_code, status: error.message, data: Errors.map(error.http_code) }
    end
  end
end
