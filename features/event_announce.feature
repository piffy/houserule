# language: it


Funzionalità: Annuncia Evento
Come organizzatore di evento
Voglio poter annunciare il nuovo evento a giocatori
Perché possano iscriversi

Contesto:
Dato   che esistono i seguenti utenti:
| name                  | email                 | password  |
| Paperino              | paolino@nomail.it     | 12345678  |
| Pluto                 | pluto@nomail.it       | 12345678  |

E che esistono i seguenti eventi dell'utente "paolino@nomail.it":
| name                  | system     | begins_at  |
| Campionato            | Risiko     | 10-5-2013  |
E che esistono i seguenti eventi dell'utente "pluto@nomail.it":
| name                  | system     | begins_at  |
| Semifinale            | Monopoli   | 21-7-2013  |


Scenario:   Navigazione
Dato mi loggo con email "paolino@nomail.it" e password "12345678"
E vado alla visualizzazione evento di "Campionato"
Allora dovrei vedere "Annuncia" all'interno di "a"
Quando seguo il link "Annuncia"
Allora dovrei trovarmi nella pagina di nuovo annuncio per "Campionato"
E dovrei vedere il titolo "Annunci"
E dovrei vedere "'Campionato'" all'interno di "h1"

Scenario: Non avente diritto
Dato mi loggo con email "paolino@nomail.it" e password "12345678"
Quando vado alla visualizzazione evento di "Semifinale"
E vado alla pagina di nuovo annuncio per "Semifinale"
Allora dovrei vedere "Azione non consentita"

@email
Scenario: Invio mail di annuncio a due email
Dato mi loggo con email "paolino@nomail.it" e password "12345678"
E vado alla pagina di nuovo annuncio per "Campionato"
Quando inserisco "topolino@nomail.com" nel campo email "0"
E inserisco "paperoga@nomail.com" nel campo email "1"
Quando premo "Invia annuncio"
Allora dovrei vedere "Annuncio inviato a 2 indirizzi"

@email
Scenario: Non inserisco email
Dato mi loggo con email "paolino@nomail.it" e password "12345678"
E vado alla pagina di nuovo annuncio per "Campionato"
Quando premo "Invia annuncio"
E dovrei vedere "Non sono stati inseriti indirizzi validi"


@email
Scenario: Invio mail di annuncio a più gruppi

@email
Scenario: Invio mail di annuncio a uno o più utenti



