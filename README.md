Karol Manarczyk, Krzysztof Baliński					     Warszawa, 21.06.2018


SPECYFIKACJA TECHNICZNA

Specyfikacja techniczno-funkcjonalna strony internetowej przeznaczonej na projekt zespołowy.

Wstęp

Strona internetowa umożliwia użytkownikowi wyszukiwanie i ocenianie książki oraz przeglądanie ocen innych użytkowników. Głównym celem w/w strony jest łatwe odnalezienie poszukiwanych przez użytkownika tytułów.

Klasy:

klasa books - zawiera informacje o książkach. 
	 
title - zawiera tytuł książki.
author - zawiera autor książki.
genre - zawiera gatunek książki.


klasa opinions - zawiera informację o opiniach dodawanych przez użytkowników.

rate - zawiera ocenę książki dokonaną przez użytkownika.
description - zawiera opis książki, który użytkownik może dodać do oceny.
user_id - zawiera numer identyfikujący użytkownika, który dodał ocenę.
book_id - zawiera numer identyfikujący książkę, którą ocenił użytkownik.
created_at - informuje, kiedy użytkownik dodał opinię na temat książki.
updated_at - informuje, kiedy użytkownik dokonał modyfikacji swojej opinii na temat książki.


klasa users - zawiera informację o użytkowniku.	

username - zawiera nazwę użytkownika.
email - zawiera mail użytkownika.
password_digest - zawiera hasło użytkownika.
admin - informuje czy użytkownik posiada prawa administratora.
created_at - informuje, kiedy użytkownik zarejestrował się w serwisie.
updated_at - informuje, kiedy użytkownik dokonał zmian swoich danych.


Funkcjonalności:

Istnieje system rejestracji i logowania.              
Umożliwia wyszukiwanie książki, za pomocą takich cech jak: tytuł, autor, gatunek. Dodatkowo system wyszukiwania udostępnia możliwość sortowania wyników wyszukiwania rosnąco lub malejąco.
Posiada mechanizm dodawania ocen i opinii książkom oraz ich edycję. 
Możliwość przeglądania innych użytkowników serwisu oraz ich ocen i opinii.
Posiadając prawa administratora istnieje możliwość dodania nowego rekordu książki.



Baza danych
	
Dane w tym projekcie są przetrzymywane w bazie danych. Został wykorzystany PostgreSQL - wolnodostępny system do zarządzania relacyjnymi bazami danych. Schemat bazy danych znajduje się w pliku: db/schema.rb. 



