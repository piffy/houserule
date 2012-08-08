# language: it

Funzionalità: Elimina prenotazione
  Come organizzatore
  voglio poter eliminare un posto già prenotato
  perché devo avere possibilità di scegliere i miei giocatori

  Contesto:
    Dato   che esistono i seguenti utenti:
      | name                  | email                 | password  | password_confirmation | nick | location   |  description |
      | Paperino              | paolino@nomail.it     | 12345678  | 12345678              | pap  | Paperopoli |  Papero      |
      | Pluto                 | pluto@nomail.it       | 12345678  | 12345678              |      | Topolinia  |  Cane        |

    E che esistono i seguenti eventi dell'utente "paolino@nomail.it":
      | name                  | system     | begins_at  |
      | Campionato            | Risiko     | 10-5-2014  |
    Dato che esiste la prenotazione dell'evento "Campionato" per l'utente "paolino@nomail.it"

    Dato   mi trovo nella pagina di login
    E      inserisco in "session_email" "paolino@nomail.it"
    E      inserisco in "session_password" "12345678"
    E      premo "Login"


  Scenario: Elimina prenotazione (con navigazione da evento)
    Dato vado alla visualizzazione evento di "Campionato"
    Quando seguo il link "Elimina prenotazione"
    Allora dovrei essere nella pagina di visualizzazione della prenotazione con id "1"
    Quando seguo il link "Elimina"
    Allora dovrei essere nella pagina di dettagli dell'evento  "Campionato"
    E il sistema ha inviato 1 email
    E dovrei vedere "Prenotazione eliminata"
    E dovrei vedere "Mail inviata all'organizzatore"
    E dovrei non vedere "Elimina prenotazione"

  Scenario: Elimina prenotazione (con navigazione da elenco eventi)
    Dato mi trovo nella pagina di elenco eventi
    Quando seguo il link "Sprenota"
    Allora dovrei essere nella pagina di visualizzazione della prenotazione con id "1"
    Quando seguo il link "Elimina"
    Allora dovrei essere nella pagina di dettagli dell'evento  "Campionato"
    E il sistema ha inviato 1 email
    E dovrei vedere "Prenotazione eliminata"
    E dovrei vedere "Mail inviata all'organizzatore"
    E dovrei non vedere "Elimina prenotazione"

  Scenario: Elimina prenotazione a evento iniziato (errore)
    Dato che esistono i seguenti eventi dell'utente "paolino@nomail.it":
      | name                  | system         | begins_at  |
      | Ritardo               | Impossible     | 10-5-2012  |
    Dato che esiste la prenotazione dell'evento "Ritardo" per l'utente "paolino@nomail.it"
    E vado alla visualizzazione evento di "Ritardo"
    Quando seguo il link "Elimina prenotazione"
    Allora dovrei essere nella pagina di dettagli dell'evento  "Ritardo"
    E dovrei vedere "Impossibile modificare la prenotazione"


  Scenario: Elimina prenotazione dopo deadline (errore)
    Dato che esistono i seguenti eventi dell'utente "paolino@nomail.it":
      | name                  | system         | begins_at  | deadline  |
      | Ritardo               | Impossible     | 10-5-2013  | 10-5-2012 |
    Dato che esiste la prenotazione dell'evento "Ritardo" per l'utente "paolino@nomail.it"
    E vado alla visualizzazione evento di "Ritardo"
    Quando seguo il link "Elimina prenotazione"
    Allora dovrei essere nella pagina di dettagli dell'evento  "Ritardo"
    E dovrei vedere "Impossibile modificare la prenotazione"


  Scenario: Elimina prenotazione da altro utente (errore)
  Dato che esistono i seguenti eventi dell'utente "pluto@nomail.it":
    | name                  | system         | begins_at  |
    | Alternative           | Strano         | 10-5-2013  |
  Dato che esiste la prenotazione dell'evento "Alternative" per l'utente "pluto@nomail.it"
  E vado alla visualizzazione evento di "Alternative"
  Quando vado alla pagina di visualizzazione della prenotazione con id "2"
  E seguo il link "Elimina"
  Allora dovrei essere nella pagina di dettagli dell'evento  "Alternative"
  E dovrei vedere "Azione non consentita"

  Scenario: Elimina prenotazione da organizzatore
  Dato che esiste la prenotazione dell'evento "Campionato" per l'utente "pluto@nomail.it"
  E vado alla visualizzazione evento di "Campionato"
  Quando vado alla pagina di visualizzazione della prenotazione con id "2"
  Allora dovrei vedere "di Pluto"
  Quando seguo il link "Elimina"
  Allora dovrei essere nella pagina di dettagli dell'evento  "Campionato"
  E il sistema ha inviato 1 email
  E dovrei vedere "Prenotazione eliminata"
  E dovrei vedere "Mail inviata all'utente"









