class Book < ApplicationRecord
    has_many    :opinions
    validates :title,   presence: {message: "Musisz podać tytuł"}
    validates :author,  presence: {message: "Musisz podać autora"}
    validates :genre,   presence: {message: "Musisz podać kategorię"}
end