# language: it

Funzionalità:
Come organizzatore di eventi
voglio poter modificare al dimensione degli iscritti
perché voglio poter avere flessibilità organizzativa


Contesto:

Dato   che esistono i seguenti utenti:
| name                  | email                 | password  |
| Pippo                 | pippo@nomail.it       | 12345678  |
| Pluto                 | pluto@nomail.it       | 12345678  |
| Qui                   | qui@nomail.it         | 12345678  |
| Quo                   | quo@nomail.it         | 12345678  |

Scenario:   Riduzione posti, no waiting list
Dato che esistono i seguenti eventi dell'utente "pippo@nomail.it":
| name                     | system        | begins_at  | max_player_num | waiting_list |
| Full event               | Yahtzee       | 10-5-2014  |              3 |            0 |
Dato che esiste la prenotazione dell'evento "Full event" per l'utente "pluto@nomail.it"
Dato che esiste la prenotazione dell'evento "Full event" per l'utente "pippo@nomail.it"
Dato che esiste la prenotazione dell'evento "Full event" per l'utente "qui@nomail.it"
Dato mi loggo con email "pippo@nomail.it" e password "12345678"
E che io mi trovo nella pagina di elenco eventi
E seguo il link "Modifica"
E premo il pulsante "Prossimo"
E inserisco in "event_max_player_num" "1"
E premo "Prossimo"
Quando vado ai dettagli di un evento
Allora dovrei non vedere "" all'interno di "span.waiting_list_count"
E dovrei vedere "1/1" all'interno di "span.reservations"
E il sistema ha inviato 2 emails
