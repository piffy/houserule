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
  Allora dovrei essere nella home page
  E dovrei vedere "Utente Paperino creato"


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
  Allora dovrei vedere il messaggio di errore "Email è già in uso"
  E dovrei vedere "Un errore non ha reso possibile il salvataggio"

Scenario:   Password  troppo corta
  Dato   mi trovo nella pagina di registrazione
  Quando inserisco in "user_name" "Paperino"
  E      inserisco in "user_email" "paolino@nomail.it"
  E      inserisco in "user_password" "1234"
  E      inserisco in "user_password_confirmation" "1234"
  Quando premo "Crea utente"
  Allora dovrei vedere il messaggio di errore "Password è troppo corto (il minimo è 6 caratteri)"
  E dovrei vedere "Un errore non ha reso possibile il salvataggio"

Scenario:   Password  troppo lunga
  Dato   mi trovo nella pagina di registrazione
  Quando inserisco in "user_name" "Paperino"
  E      inserisco in "user_email" "paolino@nomail.it"
  E      inserisco in "user_password" "1234567890123456"
  E      inserisco in "user_password_confirmation" "1234567890123456"
  Quando premo "Crea utente"
  Allora dovrei vedere il messaggio di errore "Password è troppo lungo (il massimo è 15 caratteri)"
  E dovrei vedere "Un errore non ha reso possibile il salvataggio"

  Scenario:  Nome utente assente
  Dato   che mi trovo nella pagina di registrazione
  Quando inserisco in "user_email" "paolino@nomail.it"
  E      inserisco in "user_password" "12345678"
  E      inserisco in "user_password_confirmation" "12345678"
  Quando premo "Crea utente"
  Allora dovrei vedere il messaggio di errore "Name non può essere lasciato in bianco"
  E dovrei vedere "Un errore non ha reso possibile il salvataggio"

  Scenario:  Errata conferma password
  Dato   che mi trovo nella pagina di registrazione
  Quando inserisco in "user_email" "paolino@nomail.it"
  E      inserisco in "user_password" "12345678"
  E      inserisco in "user_password_confirmation" "error"
  Quando premo "Crea utente"
  Allora dovrei vedere il messaggio di errore "Password non coincide con la conferma"
  E dovrei vedere "2 errori non hanno reso possibile il salvataggio"

  Scenario:  Conferma password vuota
  Dato   che mi trovo nella pagina di registrazione
  Quando inserisco in "user_email" "paolino@nomail.it"
  E      inserisco in "user_password" "12345678"
  Quando premo "Crea utente"
  Allora dovrei vedere il messaggio di errore "Password confirmation non può essere lasciato in bianco"
  E dovrei vedere "3 errori non hanno reso possibile il salvataggio"
