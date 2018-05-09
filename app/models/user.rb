class User < ApplicationRecord
    has_many   :opinions
    
    PASSWORD_FORMAT = /\A
  (?=.{8,})          # Must contain 8 or more characters
  (?=.*\d)           # Must contain a digit
  (?=.*[a-z])        # Must contain a lower case character
  (?=.*[A-Z])        # Must contain an upper case character
  #(?=.*[[:^alnum:]]) # Must contain a symbol
/x
    before_save { self.email = email.downcase }
    validates :username, presence:true,
            uniqueness: { case_sensitive: false },
            length: { minimum:3, maximum:25 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true,
            length: {maximum: 105 },
            uniqueness: { case_sensitive:false },
            format: { with:VALID_EMAIL_REGEX }
    validates :password, presence: true,  format: { with: PASSWORD_FORMAT }
    has_secure_password
end