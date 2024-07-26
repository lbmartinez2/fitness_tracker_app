module CalorieNinjas
  class Errors
    def self.map(code)
      case code
      when 401
        return 'Unauthorized request. Please try again!'
      when 404
        return 'Invalid request!'
      else
        return 'Service unavailable. Please try again!'
      end
    end
  end
end