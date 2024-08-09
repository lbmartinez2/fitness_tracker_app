class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations and validations
  has_many :exercises
  has_many :consumptions

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  
  validates :bmr, :amr, numericality: true, allow_nil: true
end
