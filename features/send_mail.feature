# language: it
Funzionalità: Invio email
  Come utente
  Voglio poter ricevere email
  Per tenere sotto controllo la situazione

@email
  Scenario: Invio mail di registrazione
  Dato   mi trovo nella pagina di registrazione
  Quando inserisco in "user_name" "Paperino"
  E      inserisco in "user_email" "paolino@nomail.it"
  E      inserisco in "user_password" "12345678"
  E      inserisco in "user_password_confirmation" "12345678"
  Quando premo "Nuovo utente"
  Allora dovrebbe spedire una mail di conferma registrazione a "paolino@nomail.it"


@email
  Scenario: Invio mail di cancellazione prenotazione personale
  Dato   che esistono i seguenti utenti:
    | name                  | email                 | password  | password_confirmation | nick | location   |  description |
    | Paperino              | paolino@nomail.it     | 12345678  | 12345678              | pap  | Paperopoli |  Papero      |
  E che esistono i seguenti eventi dell'utente "paolino@nomail.it":
    | name                  | system     | begins_at  |
    | Campionato            | Risiko     | 10-5-2012  |
  Dato   mi trovo nella pagina di login
  E      inserisco in "session_email" "paolino@nomail.it"
  E      inserisco in "session_password" "12345678"
  E      premo "Login"
  Dato che esiste la prenotazione dell'evento "Campionato" per l'utente "paolino@nomail.it"
  E vado alla visualizzazione evento di "Campionato"
  Quando seguo il link "Elimina prenotazione"
  Allora dovrebbe spedire una mail di conferma cancellazione prenotazione con id "1" all'"organizzatore"

@email
  Scenario: Invio mail di cancellazione prenotazione da parte dell'organizzatore
  Dato   che esistono i seguenti utenti:
    | name                  | email                 | password  | password_confirmation | nick | location   |  description |
    | Paperino              | paolino@nomail.it     | 12345678  | 12345678              | pap  | Paperopoli |  Papero      |
    | Pluto                 | pluto@nomail.it       | 12345678  | 12345678              |      | Topolinia  |  Cane        |

  E che esistono i seguenti eventi dell'utente "paolino@nomail.it":
    | name                  | system     | begins_at  |
    | Campionato            | Risiko     | 10-5-2014  |
  Dato     mi trovo nella pagina di login
    E      inserisco in "session_email" "paolino@nomail.it"
    E      inserisco in "session_password" "12345678"
    E      premo "Login"
    Dato che esiste la prenotazione dell'evento "Campionato" per l'utente "pluto@nomail.it"
    Quando vado alla pagina di visualizzazione della prenotazione con id "1"
    Allora dovrebbe spedire una mail di conferma cancellazione prenotazione con id "1" all'"utente"




