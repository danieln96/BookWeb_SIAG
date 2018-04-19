require './test/test_helper'
class UserTest < ActiveSupport::TestCase
  test "Tworzenie użytkownika bez hasla" do
    @user = User.new(username: 'user', email: 'user@example.com')
    assert @user.save
  end
  test "Tworzenie użytkownika bez emaila" do
     @user = User.new(username: 'user', password: "password12#") 
     assert @user.save
  end
  test "Tworzenie użytkownika z pełnym formularzem" do
     @user = User.new(username: 'user', email: "user@example.com", password: "password12#") 
     assert @user.save   
  end
  test "Wyświetlenie nieistniejącego użytkownika" do
     assert User.find(id:1000)
  end
end