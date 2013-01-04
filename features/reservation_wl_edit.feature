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
  | Quo                   | quo@nomail.it         | 12345678  |
  E il sistema non ha ancora inviato emails

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

Scenario:   Diminuzione della lista d'attesa
  Dato che esistono i seguenti eventi dell'utente "pippo@nomail.it":
  | name                     | system        | begins_at  | max_player_num | waiting_list |
  | Full event               | Yahtzee       | 10-5-2014  |              1 |            3 |
  Dato che esiste la prenotazione dell'evento "Full event" per l'utente "pluto@nomail.it"
  Dato che esiste la prenotazione dell'evento "Full event" per l'utente "pippo@nomail.it"
  Dato che esiste la prenotazione dell'evento "Full event" per l'utente "qui@nomail.it"
  Dato che esiste la prenotazione dell'evento "Full event" per l'utente "quo@nomail.it"
  Dato mi loggo con email "pippo@nomail.it" e password "12345678"
  E che io mi trovo nella pagina di elenco eventi
  E seguo il link "Modifica"
  E premo il pulsante "Prossimo"
  E inserisco in "event_waiting_list" "1"
  E premo "Prossimo"
  Allora dovrei vedere "0 prenotazioni modificate e 2 prenotazioni cancellate"
  Allora il sistema ha inviato 2 emails
  Quando vado ai dettagli di un evento
  Allora dovrei vedere "1/1" all'interno di "span.waiting_list_count"



Scenario:   Aumento dei posti disponibili
Dato che esistono i seguenti eventi dell'utente "pippo@nomail.it":
  | name                     | system        | begins_at  | max_player_num | waiting_list |
  | Full event               | Yahtzee       | 10-5-2014  |              1 |            2 |
  Dato che esiste la prenotazione dell'evento "Full event" per l'utente "pluto@nomail.it"
  Dato che esiste la prenotazione dell'evento "Full event" per l'utente "pippo@nomail.it"
  Dato mi loggo con email "pippo@nomail.it" e password "12345678"
  E che io mi trovo nella pagina di elenco eventi
  E seguo il link "Modifica"
  E premo il pulsante "Prossimo"
  E inserisco in "event_max_player_num" "2"
  E premo "Prossimo"
  Allora dovrei vedere "1 prenotazioni modificate e 0 prenotazioni cancellate"
  Allora il sistema ha inviato 1 email
  Quando vado ai dettagli di un evento
  Allora dovrei vedere "0/2" all'interno di "span.waiting_list_count"
  E dovrei non vedere "" all'interno di "i.icon-question-sign"


Scenario: Editing errato
  Dato che esistono i seguenti eventi dell'utente "pippo@nomail.it":
  | name                     | system        | begins_at  | max_player_num | waiting_list |
  | Full event               | Yahtzee       | 10-5-2014  |              1 |            3 |
 Dato mi loggo con email "pippo@nomail.it" e password "12345678"
  E che io mi trovo nella pagina di elenco eventi
  E seguo il link "Modifica"
  E premo il pulsante "Prossimo"
  E inserisco in "event_waiting_list" "-3"
  E premo "Prossimo"
  Allora dovrei vedere "Un errore non ha reso possibile il salvataggio"


Scenario:   Passaggio a senza limiti
Dato che esistono i seguenti eventi dell'utente "pippo@nomail.it":
| name                     | system        | begins_at  | max_player_num | waiting_list |
| Full event               | Yahtzee       | 10-5-2014  |              1 |            2 |
  Dato che esiste la prenotazione dell'evento "Full event" per l'utente "pluto@nomail.it"
  Dato che esiste la prenotazione dell'evento "Full event" per l'utente "pippo@nomail.it"
  Dato che esiste la prenotazione dell'evento "Full event" per l'utente "qui@nomail.it"
  Dato mi loggo con email "pippo@nomail.it" e password "12345678"
  E che io mi trovo nella pagina di elenco eventi
  E seguo il link "Modifica"
  E premo il pulsante "Prossimo"
  E inserisco in "event_max_player_num" "0"
  E premo "Prossimo"
  Allora dovrei vedere "2 prenotazioni modificate e 0 prenotazioni cancellate"
  E il sistema ha inviato 2 emails
  Quando vado ai dettagli di un evento
  Allora dovrei non vedere "" all'interno di "i.icon-question-sign"
