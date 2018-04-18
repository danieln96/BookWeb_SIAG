require 'csv'

#CSV.foreach('lib/seeds/BookWebBaza.csv', { :col_sep => ';' }) do |row|
#    t = Book.new
 #   t.title = row[2]
 #   t.author = row[1]
#    t.genre = row[4]
#    t.save
#    puts "#{t.title}"
#end


#Utworzenie konta dla administratora


a = User.new
a.email = "admin@example.com"
a.password = "admos384"
a.username = "admin"
a.admin = true
a.save
puts "konto admina login admin@example.com haslo: admos384"