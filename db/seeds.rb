require 'csv'

CSV.foreach('lib/seeds/BookWebBaza.csv', { :col_sep => ';' }) do |row|
    t = Book.new
    t.title = row[2]
    t.author = row[1]
    t.genre = row[4]
    t.save
    puts "#{t.title}"
end
CSV.foreach('lib/seeds/BookWebBazaUzytkownikow.csv', { :col_sep => ',' }) do |row|
   t = User.new
   t.username = row[4]
   t.email = row[3]
   t.password = row[5]
   t.created_at = row[6]
    if t.save
        puts "Zapisono użytkownika: #{t.username}"
    end
end
CSV.foreach('lib/seeds/BookWebUzytkownikKsiazka.csv', { :col_sep => ',' }) do |row|
   t = Opinion.new
   t.rate = row[3]#3
   t.description = row[4]
   t.user_id = row[6]
   t.book_id = row[2] #2
    if t.save
        puts "Zapisano #{t.rate}"
    end
end
#Utworzenie konta dla administratora
a = User.new
a.email = "admin@example.com"
a.password = "admos384"
a.username = "admin"
a.admin = true
a.save
puts "konto admina login admin@example.com haslo: admos384"