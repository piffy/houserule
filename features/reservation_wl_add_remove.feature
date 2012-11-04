# language: it

Funzionalità:
Come organizzatore di eventi
voglio permettere ai giocatori di iscriversi con riserva
perché voglio difendermi dai bidoni dell'ultimo minuto

Contesto:

Dato   che esistono i seguenti utenti:
| name                  | email                 | password  |
| Paperino              | paolino@nomail.it     | 12345678  |
| Pluto                 | pluto@nomail.it       | 12345678  |
| Paperoga              | paperoga@nomail.it    | 12345678  |

E che esistono i seguenti eventi dell'utente "paolino@nomail.it":
| name                     | system        | begins_at  | max_player_num | waiting_list |
| Crowded event            | Yahtzee       | 10-5-2014  |              1 |            1 |



@email
Scenario:   Prenotazione in waiting list  (con navigazione)
  Dato mi loggo con email "paperoga@nomail.it" e password "12345678"
  E che esiste la prenotazione dell'evento "Crowded event" per l'utente "pluto@nomail.it"
  E vado alla visualizzazione evento di "Crowded event"
  Quando seguo il link "Prenota"
  Allora dovrei essere nella pagina di prenotazione dell'evento  "Crowded event"
  E dovrei vedere "Attenzione" all'interno di "b"
  Quando premo "Confermo"
  Allora dovrei essere nella pagina di dettagli dell'evento  "Crowded event"
  E dovrei vedere "Prenotazione effettuata (lista d'attesa)"
  E dovrei vedere "Mail inviata all'organizzatore"
  E il sistema ha inviato 1 email
  E dovrei vedere "Elimina prenotazione"
  Quando vado al profilo dell'utente "paperoga@nomail.it"
  Allora dovrei vedere "Crowded event"


Scenario:   Visualizzazione status prenotazione
Dato mi loggo con email "paperoga@nomail.it" e password "12345678"
  E che esiste la prenotazione dell'evento "Crowded event" per l'utente "pluto@nomail.it"
  E che esiste la prenotazione dell'evento "Crowded event" per l'utente "paperoga@nomail.it"
  Quando vado al profilo dell'utente "paperoga@nomail.it"
  E vado alla visualizzazione evento di "Crowded event"
  E dovrei vedere "" all'interno di "i.icon-question-sign"


Scenario:   Prenotazione oltre limite waiting list impossibile
  Dato mi loggo con email "paperoga@nomail.it" e password "12345678"
  E che esiste la prenotazione dell'evento "Crowded event" per l'utente "pluto@nomail.it"
  E che esiste la prenotazione dell'evento "Crowded event" per l'utente "paolino@nomail.it"
  E vado alla prenotazione evento di "Crowded event"
  Allora dovrei vedere "Prenotazione impossibile"
  E dovrei vedere "Posti esauriti"

@email
Scenario:   Sprenotazione di un iscritto con aggiornamento lista attes (con invio mail)
  Dato mi loggo con email "pluto@nomail.it" e password "12345678"
  E che esiste la prenotazione dell'evento "Crowded event" per l'utente "pluto@nomail.it"
  E che esiste la prenotazione dell'evento "Crowded event" per l'utente "paolino@nomail.it"
  Dato vado alla visualizzazione evento di "Crowded event"
  Quando seguo il link "Elimina prenotazione"
  E seguo il link "Elimina"
  Allora dovrei essere nella pagina di dettagli dell'evento  "Crowded event"
  E dovrei vedere "Prenotazione eliminata"
  E dovrei vedere "Mail inviata all'organizzatore"
  E dovrei vedere "Nuovo giocatore prelevato dalla lista d'attesa"
  E il sistema ha inviato 2 emails
  E l'ultima mail dovrebbe contenere "paolino@nomail.it"
  E dovrei non vedere "Elimina prenotazione"
  Dato seguo il link "logout"
  E mi loggo con email "paolino@nomail.it" e password "12345678"
  Quando vado alla visualizzazione evento di "Crowded event"
  E dovrei non vedere "" all'interno di "i.icon-question-sign"
