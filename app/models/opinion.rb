class Opinion < ApplicationRecord
   belongs_to   :book
   belongs_to   :user
   
    validates :description, length: { maximum: 1000}
    validates :rate, presence: {message: "Musisz podać wartość opinii"}
    validates_inclusion_of :rate,  in: 1..5, :message => "Wartość od 1 do 5"
end