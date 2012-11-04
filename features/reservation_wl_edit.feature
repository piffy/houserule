# language: it

Funzionalità:
Come organizzatore di eventi
voglio poter modificare al dimensione degli iscritti e della lista d'attesa
perché voglio poter avere flessibilità organizzativa


Contesto:

Dato   che esistono i seguenti utenti:
| name                  | email                 | password  |
| Pippo                 | pippo@nomail.it       | 12345678  |
| Pluto                 | pluto@nomail.it       | 12345678  |
| Qui                   | qui@nomail.it         | 12345678  |


Scenario:   Incremento posti nella lista attesa
  Dato che esistono i seguenti eventi dell'utente "pippo@nomail.it":
  | name                     | system        | begins_at  | max_player_num | waiting_list |
  | Full event               | Yahtzee       | 10-5-2014  |              1 |            0 |
  Dato che esiste la prenotazione dell'evento "Full event" per l'utente "pluto@nomail.it"
  Dato mi loggo con email "pippo@nomail.it" e password "12345678"
  E che io mi trovo nella pagina di elenco eventi
  E seguo il link "Modifica"
  E premo il pulsante "Prossimo"
  E inserisco in "event_waiting_list" "1"
  E premo "Prossimo"
  Quando vado ai dettagli di un evento
  Allora dovrei vedere "0/1" all'interno di "span.waiting_list_count"

Scenario:   Diminuzione della waiting list

Scenario:   Aumento della waiting list

Scenario:   Diminuzione dei posti disponibili

