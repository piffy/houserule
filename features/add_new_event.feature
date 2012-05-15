# language: it

Funzionalità: Aggiungi evento
Come utente loggato
Voglio poter creare un nuovo evento
Per poter farlo sapere agli amici

  Contesto:
    Dato   che esistono i seguenti utenti:
      | name                  | email                 | password  | password_confirmation | nick | location   |  description |
      | Paperino              | paolino@nomail.it     | 12345678  | 12345678              | pap  | Paperopoli |  Papero      |
      | Pluto                 | pluto@nomail.it       | 12345678  | 12345678              |      | Topolinia  |  Cane        |
    E      mi trovo nella pagina di login
    E      inserisco in "session_email" "paolino@nomail.it"
    E      inserisco in "session_password" "12345678"
    E      premo "Login"
    E      mi trovo nella pagina di creazione evento

  Scenario:   Aggiugere un nuovo evento
    Dato   inserisco in "event_name" "Evento"
    E      inserisco in "event_system" "Pimpinella"
    E      inserisco in "event_duration" "3 ore"
    E      inserisco in "event_description" "Una partita davvero inutile"
    E      inserisco in "event_descr_short" "partita"
    E      inserisco in "event_location" "Paperopoli"
    E      inserisco in "event_min_player_num" "2"
    E      inserisco in "event_max_player_num" "4"
    E      seleziono la data "10-5-2013" in "event_begins_at"
    E      seleziono la data "09-5-2013" in "event_deadline"
    Quando premo "Invia"
    Allora dovrei vedere "Evento creato!"
    E mostra la pagina


  Scenario:   Dimenticare il nome (percorso triste)
    Quando premo "Invia"
    Allora dovrei vedere il messaggio di errore "non deve essere vuoto"


  Scenario:   Conferma incompatibile  (percorso triste)
    Dato   inserisco in "event_name" "Evento"
    E      seleziono la data "09-5-2013" in "event_begins_at"
    E      seleziono la data "10-5-2013" in "event_deadline"
    Quando premo "Invia"
    Allora dovrei vedere il messaggio di errore "Data di conferma errata"







