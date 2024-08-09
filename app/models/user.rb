class User < ApplicationRecord
  # Include default Devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :exercises, dependent: :destroy
  has_many :consumptions, dependent: :destroy

  # Validations
  validates :name, presence: true
end
