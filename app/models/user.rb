class User < ApplicationRecord
    after_create :send_welcome_email
  
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable
  
    private
  
    def send_welcome_email
      UserMailer.welcome_email(self).deliver_now
    end
end
  