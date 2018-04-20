class Opinion < ApplicationRecord
   belongs_to   :book
   belongs_to   :user
   
    validates :description, length: { maximum: 1000}
    validates :rate, presence: true
end