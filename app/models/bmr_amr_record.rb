class BmrAmrRecord < ApplicationRecord
    belongs_to :user
  
    validates :date, presence: true
    validates :bmr, presence: true
    validates :amr, presence: true
end
  