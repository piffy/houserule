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
  Dato  l'utente Paperino non è loggato
  E     mi trovo nella pagina di logon
  Quando inserisco in "user_email" "paolino@nomail.it"
  E      inserisco in "user_password" "12345678"
  Quando premo "Login"
  Allora dovrei essere alla home page
  E      dovrei vedere "Ciao, Paperino"


Scenario:   Logout
  Dato  l'utente Paperino è loggato
  Quando premo "Logout"
  Allora dovrei essere alla home page
  E      dovrei vedere "Utente Paperino scollegato"

Scenario:   Password errata
  Dato  l'utente Paperino non è loggato
  E     mi trovo nella pagina di logon
  Quando inserisco in "user_email" "paolino@nomail.it"
  E      inserisco in "user_password" "errore"
  Quando premo "Login"
  Allora dovrei essere alla home page
  E      dovrei vedere "Password errata"

Scenario:   Utente inesistente
  Dato   mi trovo nella pagina di logon
  Quando inserisco in "user_email" "errore@nomail.it"
  E      inserisco in "user_password" "errore"
  Quando premo "Login"
  Allora dovrei essere alla home page
  E      dovrei vedere "Utente inesistente"

Scenario:   Doppio login
  Dato  l'utente Paperino è loggato
  E     mi trovo nella pagina di logon
  Allora dovrei essere alla home page
  E      dovrei vedere "Ciao, Paperino"