# language: it


Funzionalità: Modifica utente
  Come utente loggato
  Voglio poter modificare le informazioni che mi interessano
  Per far sì che mostrino sempre dati aggiornati

Contesto:
  Dato  che esistono i seguenti utenti:
    | name                  | email                 | password  | password_confirmation |
    | Paperino              | paolino@nomail.it     | 12345678  | 12345678              |
    | Paperino              | pluto@nomail.it       | 12345678  | 12345678              |
  E      mi trovo nella pagina di login
  E      inserisco in "session_email" "paolino@nomail.it"
  E      inserisco in "session_password" "12345678"
  E      premo "Login"
  E      vado alla modifica preferenze di "paolino@nomail.it"

  Scenario:   Modifica password
    Dato inserisco in "user_password" "87654321"
    Dato inserisco in "user_password_confirmation" "87654321"
    Quando premo "Modifica"
    Allora dovrei vedere "Profilo di Paperino"
    E      dovrei vedere "Preferenze aggiornate"

  Scenario:   Modifica password (percorso triste)
    Dato inserisco in "user_password" "123"
    Quando premo "Modifica"
    Allora dovrei vedere "Modifica di Paperino"
    E dovrei vedere "error"


  Scenario:   Modifica nome
    E inserisco in "user_name" "Donald Duck"
    Dato inserisco in "user_password" "87654321"
    Dato inserisco in "user_password_confirmation" "87654321"
    Quando premo "Modifica"
    Allora dovrei vedere "Profilo di Donald Duck"
    E dovrei non vedere "error"

  Scenario:   Modifica informazioni varie
    Dato inserisco in "user_password" "12345678"
    Dato inserisco in "user_password_confirmation" "12345678"
    E inserisco in "user_description" "Un bellissimo papero"
    E inserisco in "user_nick" "Donald"
    E inserisco in "user_location" "Paperopoli"
    Quando premo "Modifica"
    Allora dovrei vedere "Profilo di Paperino"
    E dovrei vedere "Un bellissimo papero"
    E dovrei vedere "Donald"
    E dovrei vedere "Paperopoli"

  #Scenario:   Modifica dati altro utente (Errore)
  #  Quando vado alla modifica preferenze di "pluto@nomail.it"
  #  Allora dovrei vedere "Login"


