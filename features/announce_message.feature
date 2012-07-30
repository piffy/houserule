#language: it

Funzionalità: Invio di brevi messaggi a e dall'organizzatore
  Come giocatore,
  voglio poter chiedere informazioni all'organizzatore,
  per capire se l'evento mi interessa.

Contesto: Situazione iniziale
Dato   che esistono i seguenti utenti:
| name                  | email                 | password  |
| Paperino              | paolino@nomail.it     | 12345678  |
| Pluto                 | pluto@nomail.it       | 12345678  |
| Paperoga              | paperoga@nomail.it    | 12345678  |

E che esistono i seguenti eventi dell'utente "paolino@nomail.it":
| name                  | system     | begins_at  |
| Campionato            | Risiko     | 10-5-2013  |

@email
Scenario:   Prenotato -> Organizzatore
Dato mi loggo con email "pluto@nomail.it" e password "12345678"
Dato che esiste la prenotazione dell'evento "Campionato" per l'utente "pluto@nomail.it"
E il sistema non ha ancora inviato emails
E vado alla visualizzazione evento di "Campionato"
Allora dovrei vedere "Messaggi" all'interno di "a"
Quando seguo il link "Messaggi"
Allora dovrei trovarmi nella pagina di nuovo messaggio per "Campionato"
E dovrei vedere il titolo "Componi messaggio"
Quando inserisco in "announcement_subject" "Messaggio importante"
E inserisco in "announcement_body" "Non posso esserci"
Quando premo "Invia messaggio"
Allora dovrei essere nella pagina di dettagli dell'evento  "Campionato"
E dovrei vedere "Messaggio inviato"
E il sistema ha inviato 1 email

@email
Scenario:   Organizzatore -> Prenotati
Dato mi loggo con email "paolino@nomail.it" e password "12345678"
Dato che esiste la prenotazione dell'evento "Campionato" per l'utente "pluto@nomail.it"
Dato che esiste la prenotazione dell'evento "Campionato" per l'utente "paperoga@nomail.it"
E il sistema non ha ancora inviato emails
Quando vado alla pagina di nuovo messaggio per "Campionato"
Allora dovrei vedere il titolo "Componi messaggio"
E dovrei vedere "Paperoga"
E dovrei vedere "Pluto"
Quando inserisco in "announcement_subject" "Messaggio importante"
E inserisco in "announcement_body" "Non posso esserci"
Quando premo "Invia messaggio"
Allora dovrei essere nella pagina di dettagli dell'evento  "Campionato"
E dovrei vedere "2 messaggi inviati"
E il sistema ha inviato 2 email


Scenario:   Scenario:   Organizzatore ma nessun prenotato
Dato mi loggo con email "paolino@nomail.it" e password "12345678"
E il sistema non ha ancora inviato emails
Quando vado alla pagina di nuovo messaggio per "Campionato"
Allora dovrei essere nella pagina di dettagli dell'evento  "Campionato"
E dovrei vedere "Non ci sono giocatori prenotati"



Scenario:   No testo
Dato mi loggo con email "paolino@nomail.it" e password "12345678"
Dato che esiste la prenotazione dell'evento "Campionato" per l'utente "pluto@nomail.it"
Dato che esiste la prenotazione dell'evento "Campionato" per l'utente "paperoga@nomail.it"
E il sistema non ha ancora inviato emails
Quando vado alla pagina di nuovo messaggio per "Campionato"
Quando premo "Invia messaggio"
Allora dovrei essere nella pagina di dettagli dell'evento  "Campionato"



Scenario:   No destinatari
Dato mi loggo con email "paolino@nomail.it" e password "12345678"
Dato che esiste la prenotazione dell'evento "Campionato" per l'utente "pluto@nomail.it"
Dato che esiste la prenotazione dell'evento "Campionato" per l'utente "paperoga@nomail.it"
E il sistema non ha ancora inviato emails
Quando vado alla pagina di nuovo messaggio per "Campionato"
Allora dovrei vedere il titolo "Componi messaggio"
Quando deseleziono la casella "user_ids_152"
E deseleziono la casella "user_ids_153"
E inserisco in "announcement_subject" "Messaggio importante"
E inserisco in "announcement_body" "Non posso esserci"
Quando premo "Invia messaggio"
Allora dovrei essere nella pagina di dettagli dell'evento  "Campionato"
E dovrei vedere "Nessun destinatario"
E il sistema ha inviato 0 email



