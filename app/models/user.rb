class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  
  has_many :exercises
  has_many :consumptions

  validates :email, presence: true, uniqueness: true
<<<<<<< HEAD
  validates :password, presence: true
  
  validates :bmr, :amr, numericality: true, allow_nil: true
=======
  validates :password, presence: true, on: :create
  validates :bmr, numericality: { greater_than: 0 }, allow_nil: true
  validates :amr, numericality: { greater_than: 0 }, allow_nil: true

  def update_without_password(params, *args)
    params.delete(:password)
    params.delete(:password_confirmation)
    result = update(params, *args)
    clean_up_passwords
    result
  end
>>>>>>> origin/main
end
