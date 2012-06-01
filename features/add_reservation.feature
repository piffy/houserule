# language: it

Funzionalità: Prenota evento
  Come giocatore (loggato)
  voglio poter prenotare un posto nella partita
  perché l'organizzatore lo sappia.


  Contesto:
    Dato   che esistono i seguenti utenti:
      | name                  | email                 | password  | password_confirmation | nick | location   |  description |
      | Paperino              | paolino@nomail.it     | 12345678  | 12345678              | pap  | Paperopoli |  Papero      |
      | Pluto                 | pluto@nomail.it       | 12345678  | 12345678              |      | Topolinia  |  Cane        |

    E che esistono i seguenti eventi dell'utente "paolino@nomail.it":
      | name                  | system     | begins_at  |
      | Campionato            | Risiko     | 10-5-2012  |
    E che esistono i seguenti eventi dell'utente "pluto@nomail.it":
      | name                  | system     | begins_at  |
      | Semifinale            | Monopoli   | 21-7-2013  |
    Dato   mi trovo nella pagina di login
    E      inserisco in "session_email" "paolino@nomail.it"
    E      inserisco in "session_password" "12345678"
    E      premo "Login"

  Scenario: Prenotazione
    Dato vado alla visualizzazione evento di "Semifinale"
    Quando premo "Prenota"
    Allora dovrei essere alla pagina di prenotazione
    E dovrei non vedere "Prenota"
    E dovrei vedere "Prenotato"

  Scenario: Prenotazione impossibile (post-deadline)
    Dato vado alla visualizzazione evento di "Risiko"
    Allora dovrei non vedere "Prenota"

  Scenario: Prenotazione impossibile (posti esauriti)

  Scenario: Prenotazione impossibile (già prenotato)




