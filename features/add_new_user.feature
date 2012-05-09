# language: it


Funzionalità: Registrazione
  Per ottenere la piena funzionalità del sito
  Come nuovo utente
  Voglio potermi iscrivere


Scenario:   Aggiugere un nuovo utente
  Dato   mi trovo nella pagina di registrazione
  Quando inserisco in "user_name" "Paperino"
  E      inserisco in "user_email" "paolino@nomail.it"
  E      inserisco in "user_password" "12345678"
  E      inserisco in "user_password_confirmation" "12345678"
  Quando premo "Crea utente"
  #Allora dovrei essere rediretto alla homepage
  Allora dovrei vedere "Utente Paperino creato"


Scenario:   Email esistente
  Dato   esistono i seguenti utenti:
  | name                  | email                 | password  | password_confirmation |
  | Paperino              | paolino@nomail.it     | 12345678  | 12345678              |
  Dato   mi trovo nella pagina di registrazione
  Quando inserisco in "user_name" "Paperino"
  E      inserisco in "user_email" "paolino@nomail.it"
  E      inserisco in "user_password" "12345678"
  E      inserisco in "user_password_confirmation" "12345678"
  Quando premo "Crea utente"
  Allora dovrei vedere il messaggio di errore "Email has already been taken"

Scenario:   Password  troppo corta
  Dato   mi trovo nella pagina di registrazione
  Quando inserisco in "user_name" "Paperino"
  E      inserisco in "user_email" "paolino@nomail.it"
  E      inserisco in "user_password" "1234"
  E      inserisco in "user_password_confirmation" "1234"
  Quando premo "Crea utente"
  Allora dovrei vedere il messaggio di errore "Password is too short (minimum is 6 characters)"


Scenario:   Password  troppo lunga
  Dato   mi trovo nella pagina di registrazione
  Quando inserisco in "user_name" "Paperino"
  E      inserisco in "user_email" "paolino@nomail.it"
  E      inserisco in "user_password" "1234567890123456"
  E      inserisco in "user_password_confirmation" "1234567890123456"
  Quando premo "Crea utente"
  Allora dovrei vedere il messaggio di errore "Password is too long (maximum is 15 characters)"


  Scenario:  Nome utente assente
  Dato   che mi trovo nella pagina di registrazione
  Quando inserisco in "user_email" "paolino@nomail.it"
  E      inserisco in "user_password" "12345678"
  E      inserisco in "user_password_confirmation" "12345678"
  Quando premo "Crea utente"
  Allora dovrei vedere il messaggio di errore "Name can't be blank"

  Scenario:  Errata conferma password
  Dato   che mi trovo nella pagina di registrazione
  Quando inserisco in "user_email" "paolino@nomail.it"
  E      inserisco in "user_password" "12345678"
  E      inserisco in "user_password_confirmation" "error"
  Quando premo "Crea utente"
  Allora dovrei vedere il messaggio di errore "doesn't match confirmation"

  Scenario:  Conferma password vuota
  Dato   che mi trovo nella pagina di registrazione
  Quando inserisco in "user_email" "paolino@nomail.it"
  E      inserisco in "user_password" "12345678"
  Quando premo "Crea utente"
  Allora dovrei vedere il messaggio di errore "confirmation can't be blank"

