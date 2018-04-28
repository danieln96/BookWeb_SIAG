class Book < ApplicationRecord
    has_many    :opinions
    validates :title,   presence: true, uniqueness: { case_sensitive: false }
    validates :author,  presence: true
    validates :genre,   presence: true
end