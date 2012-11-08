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
      | name                  | system     | begins_at  | deadline   | max_player_num | min_player_num |
      | Semifinale            | Monopoli   | 21-7-2013  | 21-7-2013  |       1        |        1       |
      | Investigazione        | Cluedo     | 21-7-2015  | 21-5-2012  |       0        |        0       |
    Dato   mi trovo nella pagina di login
    E      inserisco in "session_email" "paolino@nomail.it"
    E      inserisco in "session_password" "12345678"
    E      premo "Login"

  Scenario: Prenotazione (con navigazione)
    Dato vado alla visualizzazione evento di "Semifinale"
    Quando seguo il link "Prenota"
    Allora dovrei essere nella pagina di prenotazione dell'evento  "Semifinale"
    Quando premo "Confermo"
    Allora dovrei essere nella pagina di dettagli dell'evento  "Semifinale"
    E dovrei vedere "Prenotazione effettuata"
    E dovrei vedere "Mail inviata all'organizzatore"
    E il sistema ha inviato 1 email
    E dovrei vedere "Elimina prenotazione"

    Scenario: Prenotazione (con navigazione, senza deadline)
    Dato che l'evento "Semifinale" non ha deadline
    Dato vado alla visualizzazione evento di "Semifinale"
    Quando seguo il link "Prenota"
    Allora dovrei essere nella pagina di prenotazione dell'evento  "Semifinale"
    Quando premo "Confermo"
    Allora dovrei essere nella pagina di dettagli dell'evento  "Semifinale"
    E dovrei vedere "Prenotazione effettuata"
    E dovrei vedere "Mail inviata all'organizzatore"
    E il sistema ha inviato 1 email
    E dovrei vedere "Elimina prenotazione"


Scenario: Prenotazione impossibile (già prenotato)
    Dato vado alla prenotazione evento di "Semifinale"
    Quando premo "Confermo"
    Allora dovrei essere nella pagina di dettagli dell'evento  "Semifinale"
    E dovrei vedere "Prenotazione effettuata"
    Quando vado alla prenotazione evento di "Semifinale"
    Allora dovrei vedere "Prenotazione impossibile"
    E dovrei vedere "prenotato"


  Scenario: Prenotazione impossibile (iniziato)
    Dato vado alla prenotazione evento di "Campionato"
    Allora dovrei vedere "Prenotazione impossibile"
    E dovrei vedere "iniziato"

  Scenario: Prenotazione impossibile (post-deadline)
    Dato vado alla prenotazione evento di "Investigazione"
    Allora dovrei vedere "Prenotazione impossibile"
    E dovrei vedere "prenotare dopo"


  Scenario: Prenotazione impossibile (posti esauriti)
    Dato che esiste la prenotazione dell'evento "Semifinale" per l'utente "pluto@nomail.it"
    E vado alla prenotazione evento di "Semifinale"
    Allora dovrei vedere "Prenotazione impossibile"
    E dovrei vedere "Posti esauriti"

  Scenario: Prenotazione manuale con invito
    Dato che esiste l'invito all'evento "Semifinale" per l'utente "paolino@nomail.it"
    Dato vado alla visualizzazione evento di "Semifinale"
    Quando seguo il link "Prenota"
    Allora dovrei essere nella pagina di prenotazione dell'evento  "Semifinale"
    Quando premo "Confermo"
    Allora dovrei essere nella pagina di dettagli dell'evento  "Semifinale"
    E dovrei vedere "Prenotazione effettuata"
    E dovrei vedere "Elimina prenotazione"
    Quando vado al profilo dell'utente "paolino@nomail.it"
    Allora dovrei non vedere "Inviti pendenti"





