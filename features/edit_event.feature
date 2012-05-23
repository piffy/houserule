# language: it


Funzionalità: Modifica Evento
  Come organizzatore di evento
  Voglio poter modificare le informazioni che mi interessano
  Per far sì che mostrino sempre dati aggiornati

  Contesto:
  Contesto:
    Dato   che esistono i seguenti utenti:
      | name                  | email                 | password  | password_confirmation | nick | location   |  description |
      | Paperino              | paolino@nomail.it     | 12345678  | 12345678              | pap  | Paperopoli |  Papero      |
      | Pluto                 | pluto@nomail.it       | 12345678  | 12345678              |      | Topolinia  |  Cane        |
    E mi loggo con email "paolino@nomail.it" e password "12345678"
    E che esistono i seguenti eventi dell'utente "paolino@nomail.it":
      | name                  | system     | begins_at  |
      | Campionato            | Risiko     | 10-5-2013  |
    E che esistono i seguenti eventi dell'utente "pluto@nomail.it":
      | name                  | system     | begins_at  |
      | Semifinale            | Monopoli   | 21-7-2013  |

  Scenario:   Modifica completa
    Dato   vado alla modifica evento di "Campionato"
    Dato   inserisco in "event_name" "Finale"
    E      inserisco in "event_system" "Pimpinella"
    E      inserisco in "event_duration" "3 ore"
    E      inserisco in "event_description" "Una partita davvero inutile"
    E      inserisco in "event_descr_short" "partita"
    E      inserisco in "event_location" "Paperopoli"
    E      inserisco in "event_min_player_num" "2"
    E      inserisco in "event_max_player_num" "4"
    E      seleziono la data "10-11-2013" in "event_begins_at"
    E      seleziono la data "09-5-2013" in "event_deadline"
    Quando premo "Invia"
    Allora dovrei vedere "Event was successfully updated"


  Scenario:   Utente errato
    Quando vado alla modifica evento di "Semifinale"
    Allora dovrei essere nella home page
    E dovrei vedere il messaggio di errore "Non puoi modificare gli eventi altrui"


