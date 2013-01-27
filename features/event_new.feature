# language: it

Funzionalità: Aggiungi evento
Come organizzatore (loggato)
voglio poter creare una partita
perché gli altri utenti si possano iscrivere

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
    E      inserisco in "event_description" "Una partita davvero inutile"
    E      inserisco in "event_descr_short" "partita"
    Quando premo "Prossimo"
    Allora dovrei vedere "Evento creato con successo"
    Quando      inserisco in "event_system" "Pimpinella"
    E      inserisco in "event_min_player_num" "2"
    E      inserisco in "event_max_player_num" "4"
    Quando premo "Prossimo"
    Allora dovrei vedere "Questo evento non ha ancora una data stabilita"
    E      inserisco in "event_duration" "3 ore"
    E      inserisco in "event_location" "Paperopoli"
    E      inserisco in "event_begins_at_date_only" "10-05-2013"
    E      inserisco in "event_deadline_date_only" "09-05-2013"
    Quando premo "Prossimo"
    Quando premo "Termina"
    Allora dovrei essere nella pagina di dettagli dell'evento  "Evento"
    E dovrei vedere "Evento modificato con successo"

  Scenario:   Dimenticare il nome (percorso triste)
    Quando premo "Prossimo"
    Allora dovrei vedere il messaggio di errore "Name non deve essere vuoto"
    E dovrei vedere "Un errore non ha reso possibile il salvataggio"

  Scenario:   Numero giocatori errato (percorso triste)
    Dato   inserisco in "event_name" "Evento"
    Quando premo "Prossimo"
    Quando      inserisco in "event_system" "Pimpinella"
    E      inserisco in "event_min_player_num" "4"
    E      inserisco in "event_max_player_num" "2"
    Quando premo "Prossimo"
    Allora dovrei vedere il messaggio di errore "Max player num deve essere superiore o uguale a 4"
    E dovrei vedere "Un errore non ha reso possibile il salvataggio"


  Scenario:   Conferma impossibile  (percorso triste)
    Dato   inserisco in "event_name" "Evento"
    Quando premo "Prossimo"
    Quando premo "Prossimo"
    E      inserisco in "event_begins_at_date_only" "09-05-2013"
    E      inserisco in "event_deadline_date_only" "11-05-2013"
    E scelgo "standard"
    Quando premo "Prossimo"
    Allora dovrei vedere il messaggio di errore "Deadline non deve precedere l'inizio"
    E dovrei vedere "Un errore non ha reso possibile il salvataggio"






