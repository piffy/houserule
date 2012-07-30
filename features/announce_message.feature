#language: it

Funzionalità: Invio di brevi messaggi all'organizzatore
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
Scenario:   Utente -> Organizzatore
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
* mostra la pagina
Allora dovrei essere nella pagina di dettagli dell'evento  "Campionato"
E dovrei vedere "Messaggio inviato"
E il sistema ha inviato 1 email


Scenario:   Utente
Dato mi loggo con email "paolino@nomail.it" e password "12345678"
Dato che esiste la prenotazione dell'evento "Campionato" per l'utente "pluto@nomail.it"
Dato che esiste la prenotazione dell'evento "Campionato" per l'utente "paperoga@nomail.it"
E il sistema non ha ancora inviato emails
Quando vado alla pagina di nuovo messaggio per "Campionato"
E dovrei vedere il titolo "Componi messaggio"


Scenario:   Invio informazioni
Dato mi loggo con email "paperino@nomail.it" e password "12345678"





