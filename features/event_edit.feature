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

    E che esistono i seguenti eventi dell'utente "paolino@nomail.it":
      | name                  | system     | begins_at  |  deadline |
      | Campionato            | Risiko     | 10-5-2013  | 9-5-2013  |
    E che esistono i seguenti eventi dell'utente "pluto@nomail.it":
      | name                  | system     | begins_at  |
      | Semifinale            | Monopoli   | 21-7-2013  |

  Scenario:   Modifica Nome
    Dato   mi trovo nella pagina di login
    E      inserisco in "session_email" "paolino@nomail.it"
    E      inserisco in "session_password" "12345678"
    E      premo "Login"
    E      vado alla modifica evento di "Campionato"
    Allora dovrei vedere "Modifica"
    Quando inserisco in "event_name" "Finale"
    E      inserisco in "event_description" "Una partita davvero inutile"
    E      inserisco in "event_descr_short" "partita"
    E      premo "Prossimo"
    Allora dovrei vedere "Evento aggiornato"


  Scenario:   Utente non loggato
    Quando vado alla modifica evento di "Semifinale"
    Allora dovrei essere nella pagina di login


  Scenario:   Utente errato
    Dato   mi trovo nella pagina di login
    E      inserisco in "session_email" "paolino@nomail.it"
    E      inserisco in "session_password" "12345678"
    E      premo "Login"
    Quando vado alla modifica evento di "Semifinale"
    Allora dovrei essere nella pagina di dettagli dell'evento  "Semifinale"
    E dovrei vedere "Azione non consentita"


  Scenario:   Cambiamento da standard a senza deadline
    Dato   mi loggo con email "paolino@nomail.it" e password "12345678"
    E      vado alla modifica evento di "Campionato"
    E      premo "Prossimo"
    E      premo "Prossimo"
    Quando scelgo "no_deadline"
    E premo "Prossimo"
    E vado alla visualizzazione evento di "Campionato"
    #Allora dovrei essere nella pagina di dettagli dell'evento  "Campionato"
    E dovrei non vedere "Deadline"


  Scenario:   Eliminazione di un evento
  Dato   mi loggo con email "paolino@nomail.it" e password "12345678"
  E      vado alla modifica evento di "Campionato"
  #simulo pressione tasto
  E      vado all'eliminazione dell'evento "Campionato"
  Allora dovrei vedere "Evento eliminato con successo"
  E dovrei non vedere "Campionato"

