require 'csv'

CSV.foreach('lib/seeds/BookWebBaza.csv', { :col_sep => ';' }) do |row|
    t = Book.new
    t.title = row[2]
    t.author = row[1]
    t.genre = row[4]
    t.save
    puts "#{t.title}"
end


#Utworzenie konta dla administratora


a = User.new
a.email = "admin@example.com"
a.password_digest = "password"
a.username = "admin"
a.save
