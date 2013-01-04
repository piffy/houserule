#language: it

Funzionalità: Invitare persone
Come organizzatore
Voglio potere invitare alcune persone
Per essere sicuro che siano informate

Contesto: Situazione iniziale

Dato   che esistono i seguenti utenti:
| name                  | email                 | password  |
| Paperino              | paolino@nomail.it     | 12345678  |
| Pluto                 | pluto@nomail.it       | 12345678  |
| Paperoga              | papaeroga@nomail.it   | 12345678  |

E che esistono i seguenti eventi dell'utente "paolino@nomail.it":
| name                  | system     | begins_at  |
| Campionato            | Risiko     | 10-5-2013  |
| Scadenza              | Yatzee     | 10-4-2013  |

E che esistono i seguenti eventi dell'utente "pluto@nomail.it":
| name                  | system     | begins_at  |
| Semifinale            | Monopoli   | 21-7-2013  |

Scenario:   Navigazione
Dato mi loggo con email "paolino@nomail.it" e password "12345678"
E vado alla visualizzazione evento di "Campionato"
Allora dovrei vedere "Inviti" all'interno di "a"
Quando seguo il link "Inviti"
Allora dovrei trovarmi nella pagina di elenco inviti per "Campionato"
Allora dovrei vedere "Invita" all'interno di "a"
Quando seguo il link "Invita"
Allora dovrei trovarmi nella pagina di nuovi inviti per "Campionato"
E dovrei vedere il titolo "Inviti"
E dovrei vedere "'Campionato'" all'interno di "h1"
E dovrei vedere "Pluto" all'interno di "label"
E dovrei vedere "Paperoga" all'interno di "label"
E dovrei non vedere "Paperino" all'interno di "label"



Scenario: Personalizza scadenza

Scenario: Scadenza errata

Scenario: Non loggato
Dato non sono loggato come utente "Paperino"
Quando vado alla visualizzazione evento di "Campionato"
Allora dovrei non vedere "Invita" all'interno di "a"
Quando vado alla pagina di nuovi inviti per "Campionato"
Allora dovrei essere nella pagina di login

Scenario: Non avente diritto
Dato mi loggo con email "paolino@nomail.it" e password "12345678"
Quando vado alla visualizzazione evento di "Semifinale"
Allora dovrei non vedere "Invita" all'interno di "a"
Quando vado alla pagina di nuovi inviti per "Semifinale"
Allora dovrei vedere "Azione non consentita"

@email
Scenario:   Nuovo invito a utenti
Dato il sistema non ha ancora inviato email
E mi loggo con email "paolino@nomail.it" e password "12345678"
Quando vado alla pagina di nuovi inviti per "Campionato"
Quando seleziono la casella "Pluto"
E seleziono la casella "Paperoga"
Quando premo "Spedisci inviti"
Allora dovrei trovarmi nella pagina di elenco inviti per "Campionato"
E dovrei vedere "2 email con l'invito spedite"
E dovrei vedere "Pluto" all'interno di "td.user_listing"
E dovrei vedere "In attesa" all'interno di "div.label"
E dovrei vedere "Paperoga" all'interno di "td.user_listing"
E il sistema ha inviato 2 email
E l'ultima mail dovrebbe contenere "Paperino"


Scenario:   Impedisci doppio invito  se già invitato
Dato mi loggo con email "paolino@nomail.it" e password "12345678"
Dato che esiste l'invito all'evento "Campionato" per l'utente "pluto@nomail.it"
Allora vado alla pagina di elenco inviti per "Campionato"
Quando vado alla pagina di nuovi inviti per "Campionato"
Allora dovrei non vedere "Pluto" all'interno di "label"


Scenario:   Impedisci doppio invito  se già prenotato
Dato mi loggo con email "paolino@nomail.it" e password "12345678"
E che esiste la prenotazione dell'evento "Campionato" per l'utente "pluto@nomail.it"
Quando vado alla pagina di nuovi inviti per "Campionato"
Allora dovrei non vedere "Pluto" all'interno di "label"


Scenario:   Visualizzazione invito nel profilo
  Dato mi loggo con email "pluto@nomail.it" e password "12345678"
  E che esiste l'invito all'evento "Campionato" per l'utente "pluto@nomail.it"
  E che esiste l'invito scaduto all'evento "Scadenza" per l'utente "pluto@nomail.it"
  Quando vado al profilo dell'utente "pluto@nomail.it"
  Allora dovrei vedere "Inviti pendenti (2):"
  E dovrei vedere "Campionato" all'interno di "a"
  E dovrei non vedere "Scadenza" all'interno di "a"
  E dovrei vedere "Scaduto"
  Quando vado alla visualizzazione evento di "Campionato"
  Allora dovrei vedere "Inviti (1):"

@email
Scenario:   Invio inviti evento senza deadline
  Dato mi loggo con email "paolino@nomail.it" e password "12345678"
  E vado alla visualizzazione evento di "Campionato"
  E che l'evento "Campionato" non ha deadline
  Allora dovrei vedere "Inviti" all'interno di "a"
  Quando seguo il link "Inviti"
  Allora dovrei trovarmi nella pagina di elenco inviti per "Campionato"
  Allora dovrei vedere "Invita" all'interno di "a"
  Quando seguo il link "Invita"
  Allora dovrei trovarmi nella pagina di nuovi inviti per "Campionato"
  E dovrei vedere il titolo "Inviti"
  E dovrei vedere "'Campionato'" all'interno di "h1"
  E dovrei vedere "Pluto" all'interno di "label"
  E dovrei vedere "Paperoga" all'interno di "label"
  E dovrei non vedere "Paperino" all'interno di "label"
  Quando seleziono la casella "Pluto"
  E seleziono la casella "Paperoga"
  Quando premo "Spedisci inviti"
  Allora dovrei trovarmi nella pagina di elenco inviti per "Campionato"
  E dovrei vedere "2 email con l'invito spedite"
  E dovrei vedere "Pluto" all'interno di "td.user_listing"
  E dovrei vedere "In attesa" all'interno di "div.label"
  E dovrei vedere "Paperoga" all'interno di "td.user_listing"
  E il sistema ha inviato 2 email
  E l'ultima mail dovrebbe contenere "Paperino"
