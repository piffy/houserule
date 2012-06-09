# language: it

Funzionalità: Login
  Per accedere alle funzionalità avanzate
  Come utente registrato
  Voglio poter fare il logon

Contesto:
  Dato   esistono i seguenti utenti:
    | name                  | email                 | password  |
    | Paperino              | paolino@nomail.it     | 12345678  |



Scenario:   Login
  Dato   mi trovo nella pagina di login
  E      non sono loggato come utente "Paperino"
  Quando inserisco in "session_email" "paolino@nomail.it"
  E      inserisco in "session_password" "12345678"
  Quando premo "Login"
  Allora dovrei vedere "Profilo di Paperino"

  Scenario:   Password errata
    Dato   mi trovo nella pagina di login
    Quando inserisco in "session_email" "paolino@nomail.it"
    E      inserisco in "session_password" "errore"
    Quando premo "Login"
    Allora dovrei vedere "errata"


  Scenario:   Utente inesistente
    Dato   mi trovo nella pagina di login
    Quando inserisco in "session_email" "errore@nomail.it"
    E      inserisco in "session_password" "errore"
    Quando premo "Login"
    Allora dovrei vedere "errata"


  Scenario:   Accesso a preferenze senza login
    Dato   vado alla modifica preferenze di "paolino@nomail.it"
    Allora dovrei vedere "Login"

  Scenario:   Accesso a prenotazioni senza login
    Dato che esistono i seguenti eventi dell'utente "paolino@nomail.it":
      | name                  | system     | begins_at  |
      | Campionato            | Risiko     | 10-5-2015  |
    Quando vado alla visualizzazione evento di "Campionato"
    E seguo il link "Prenota"
    Allora dovrei vedere "Login"


  Scenario:   Redirect amichevole
    Dato   vado alla modifica preferenze di "paolino@nomail.it"
    Allora dovrei vedere "Login"
    Quando inserisco in "session_email" "paolino@nomail.it"
    E      inserisco in "session_password" "12345678"
    Quando premo "Login"
    Allora dovrei vedere "Modifica"

  Scenario:   Non ripetere il login
    Dato   mi trovo nella pagina di login
    E      non sono loggato come utente "Paperino"
    Quando inserisco in "session_email" "paolino@nomail.it"
    E      inserisco in "session_password" "12345678"
    Quando premo "Login"
    Allora dovrei vedere "Profilo di Paperino"
    Quando mi trovo nella pagina di login
    Allora dovrei essere nella home page
    E dovrei vedere "Sei già loggato"

  Scenario:   Non ricreare utente
    Dato   mi trovo nella pagina di login
    E      non sono loggato come utente "Paperino"
    Quando inserisco in "session_email" "paolino@nomail.it"
    E      inserisco in "session_password" "12345678"
    Quando premo "Login"
    Allora dovrei vedere "Profilo di Paperino"
    Quando   mi trovo nella pagina di registrazione
    Allora dovrei essere nella home page
    E dovrei vedere "Sei già loggato"
