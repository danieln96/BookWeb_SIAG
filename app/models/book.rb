require 'net/http'
class Book < ApplicationRecord
    has_many    :opinions
    validates :title,   presence: {message: "Musisz podać tytuł"}
    validates :author,  presence: {message: "Musisz podać autora"}
    validates :genre,   presence: {message: "Musisz podać kategorię"}


    def position
      books = Book.all
      i=1
      books.each do |book|
        if book.id == self.id
          return i
        end
        i+=1
      end
    end
end
