# language: it

Funzionalità:
Come giocatore
voglio vedere la dimensione della waiting list
per decidere quando prenotarmi

Contesto:

Dato   che esistono i seguenti utenti:
| name                  | email                 | password  |
| Pippo                 | pippo@nomail.it       | 12345678  |
| Pluto                 | pluto@nomail.it       | 12345678  |
| Qui                   | qui@nomail.it         | 12345678  |


Scenario:   Visualizzazione lista attesa (posti disponibli in lista)
  Dato che esistono i seguenti eventi dell'utente "pippo@nomail.it":
  | name                     | system        | begins_at  | max_player_num | waiting_list |
  | Crowded event            | Yahtzee       | 10-5-2014  |              1 |            2 |
  Dato che esiste la prenotazione dell'evento "Crowded event" per l'utente "pluto@nomail.it"
  Dato che io mi trovo nella pagina di elenco eventi
  Allora dovrei vedere "1 / 1" all'interno di "span.reservations"
  E dovrei vedere "+0" all'interno di "span.waiting_list_count"
  E dovrei vedere "In lista" all'interno di "a"
  Quando vado ai dettagli di un evento
  Allora dovrei vedere "0/2" all'interno di "span.waiting_list_count"
  E dovrei vedere "1/1" all'interno di "span.reservations"

Scenario:   Visualizzazione lista attesa (posti normali disponibli)
  Dato che esistono i seguenti eventi dell'utente "pippo@nomail.it":
  | name                     | system        | begins_at  | max_player_num | waiting_list |
  | Empty event              | Yahtzee       | 10-5-2014  |              1 |            0 |
  E che io mi trovo nella pagina di elenco eventi
  Allora dovrei vedere "0 / 1" all'interno di "span.reservations"
  E dovrei vedere "Prenota" all'interno di "a"
  Ma dovrei non vedere "+0" all'interno di "span.waiting_list_count"
  Quando vado ai dettagli di un evento
  Allora dovrei non vedere "" all'interno di "span.waiting_list_count"
  E dovrei vedere "0/1" all'interno di "span.reservations"

Scenario:   Visualizzazione nell'elenco eventi (posti esauriti)
  Dato che esistono i seguenti eventi dell'utente "pippo@nomail.it":
  | name                     | system        | begins_at  | max_player_num | waiting_list |
  | Full event               | Yahtzee       | 10-5-2014  |              1 |            1 |
  Dato che esiste la prenotazione dell'evento "Full event" per l'utente "pluto@nomail.it"
  Dato che esiste la prenotazione dell'evento "Full event" per l'utente "qui@nomail.it"
  E che io mi trovo nella pagina di elenco eventi
  Allora dovrei vedere "1 / 1" all'interno di "span.reservations"
  E dovrei vedere "+1" all'interno di "span.waiting_list_count"
  E dovrei non vedere "Prenota" all'interno di "a"
  Quando vado ai dettagli di un evento
  Allora dovrei vedere "1/1" all'interno di "span.waiting_list_count"
  E dovrei vedere "1/1" all'interno di "span.reservations"


