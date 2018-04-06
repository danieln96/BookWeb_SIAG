class Opinion < ApplicationRecord
   belongs_to   :book
   belongs_to   :user
   
    validates :description, presence: true, length: {minimum: 3, maximum: 1000}
    validates :rate, presence: true
end