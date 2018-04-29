class Book < ApplicationRecord
    has_many    :opinions
    validates :title,   presence: true
    validates :author,  presence: true
    validates :genre,   presence: true
end