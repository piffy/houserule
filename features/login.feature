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


#Scenario:   Logout
#Lo scenario non puo' essere testato con Cucumber. Almeno per ora

