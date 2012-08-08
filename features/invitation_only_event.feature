# language: it

Funzionalità:  Eventi (chiusi) e senza iscrizioni
  Come organizzatore di eventi
  voglio permettere solo agli invitati di iscriversi
  perché sono molto scontroso

  Contesto: Esiste un evento chiuso
    Dato   che esistono i seguenti utenti:
      | name                  | email                 | password  | password_confirmation | nick | location   |  description |
      | Paperino              | paolino@nomail.it     | 12345678  | 12345678              | pap  | Paperopoli |  Papero      |
      | Pluto                 | pluto@nomail.it       | 12345678  | 12345678              |      | Topolinia  |  Cane        |


  Scenario:  Creazione di evento chiuso
    Dato mi loggo con email "paolino@nomail.it" e password "12345678"
    Quando mi trovo nella pagina di creazione evento
    E   inserisco in "event_name" "Evento chiuso"
    E   inserisco in "event_system" "Paths of glory"
    E   seleziono la casella "event_invite_only"
    Quando premo "Invia"
    Allora dovrei vedere "Evento creato!"
    Quando vado alla visualizzazione evento di "Evento chiuso"
    Allora dovrei vedere "Solo invitati"
    E dovrei non vedere "Prenota"
    Quando mi trovo nella pagina di elenco eventi
    Allora dovrei vedere "Evento chiuso"
    E dovrei non vedere "Prenota" all'interno di "li"

  Scenario:  Creazione di evento con blocco prenotazioni
    Dato mi loggo con email "paolino@nomail.it" e password "12345678"
    Quando mi trovo nella pagina di creazione evento
    E   inserisco in "event_name" "Evento bloccato"
    E   inserisco in "event_system" "Avogadro"
    E   seleziono la casella "event_reservation_locked"
    Quando premo "Invia"
    Allora dovrei vedere "Evento creato!"
    Quando vado alla visualizzazione evento di "Evento bloccato"
    Allora dovrei vedere "Prenotazioni bloccate"
    E dovrei non vedere "Prenota" all'interno di "li"
    Quando mi trovo nella pagina di elenco eventi
    Allora dovrei vedere "Evento bloccato"
    E dovrei non vedere "Prenota" all'interno di "li"

  Scenario: Prova iscrizione (evento a inviti)
    Dato che esistono i seguenti eventi dell'utente "paolino@nomail.it":
      | name                  | system     | begins_at  |
      | Campionato            | Strange    | 10-5-2013  |
    E l'evento "Campionato" è "riservato"
    Dato mi loggo con email "pluto@nomail.it" e password "12345678"
    E vado alla prenotazione evento di "Campionato"
    Quando premo "Confermo"
    Allora dovrei essere nella pagina di dettagli dell'evento  "Campionato"
    E dovrei vedere "Prenotazione impossibile: evento a inviti"

  Scenario: Prova iscrizione (evento a inviti)
    Dato che esistono i seguenti eventi dell'utente "paolino@nomail.it":
      | name                  | system     | begins_at  |
      | Campionato            | Strange    | 10-5-2013  |
    E l'evento "Campionato" è "bloccato"
    Dato mi loggo con email "pluto@nomail.it" e password "12345678"
    E vado alla prenotazione evento di "Campionato"
    Quando premo "Confermo"
    Allora dovrei essere nella pagina di dettagli dell'evento  "Campionato"
    E dovrei vedere "Prenotazione impossibile: prenotazioni bloccate"

  Scenario: Invio inviti
    Dato che esistono i seguenti eventi dell'utente "paolino@nomail.it":
      | name                  | system     | begins_at  |
      | Campionato            | Strange    | 10-5-2013  |
    E l'evento "Campionato" è "bloccato"
    Dato mi loggo con email "paolino@nomail.it" e password "12345678"
    Quando vado alla pagina di nuovi inviti per "Campionato"
    Allora dovrei vedere "Attenzione!"

  Scenario: Accettazione invito per evento chiuso
    Dato che esistono i seguenti eventi dell'utente "paolino@nomail.it":
      | name                  | system     | begins_at  |
      | Campionato            | Strange    | 10-5-2013  |
    E l'evento "Campionato" è "riservato"
    E che esiste l'invito all'evento "Campionato" per l'utente "pluto@nomail.it"
    Dato mi loggo con email "pluto@nomail.it" e password "12345678"
    E vado alla pagina di conferma invito dell'evento "Campionato" dell'utente "Pluto"
    Quando premo il pulsante "Confermo"
    Allora dovrei essere nella pagina di dettagli dell'evento  "Campionato"
    E dovrei vedere "Invito accettato e prenotazione effettuata."

  Scenario: Accettazione invito per evento con prenotazioni bloccato
    Dato che esistono i seguenti eventi dell'utente "paolino@nomail.it":
      | name                  | system     | begins_at  |
      | Campionato            | Strange    | 10-5-2013  |
    E l'evento "Campionato" è "bloccato"
    E che esiste l'invito all'evento "Campionato" per l'utente "pluto@nomail.it"
    Dato mi loggo con email "pluto@nomail.it" e password "12345678"
    E vado alla pagina di conferma invito dell'evento "Campionato" dell'utente "Pluto"
    Quando premo il pulsante "Confermo"
    E dovrei vedere "Impossibile prenotare"



