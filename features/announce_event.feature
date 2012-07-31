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
| Paperoga              | papaeroga@nomail.it   | 12345678  |

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
E il sistema non ha ancora inviato emails
E vado alla pagina di nuovo annuncio per "Campionato"
Quando inserisco "topolino@nomail.com" nel campo email "0"
E inserisco "paperoga@nomail.com" nel campo email "1"
Quando premo "Invia annuncio a questi indirizzi"
Allora dovrei vedere "Annuncio inviato a 2 indirizzi"
E il sistema ha inviato 1 emails

Scenario: Non inserisco email
Dato mi loggo con email "paolino@nomail.it" e password "12345678"
E vado alla pagina di nuovo annuncio per "Campionato"
Quando premo "Invia annuncio a questi indirizzi"
E dovrei vedere "Non sono stati inseriti indirizzi"


@email
Scenario: Invio mail di annuncio a uno o più gruppi
Dato che esistono i seguenti gruppi di "paolino@nomail.it":
| name                  | description               |
| Gruppo 1              | Un grande gruppo          |
| Gruppo 2              | Un altro gruppo           |
E che esistono i seguenti gruppi di "pluto@nomail.it":
| name                  | description               |
| Gruppo 3              | Gruppo interessante       |
| Gruppo 4              | Gruppo poco interessante  |
Dato a "Paperino" interessa il gruppo "Gruppo 3"
Dato mi loggo con email "paolino@nomail.it" e password "12345678"
E vado alla pagina di nuovo annuncio per "Campionato"
Allora dovrei vedere "Gruppo 1"
E dovrei vedere "Gruppo 2"
E dovrei vedere "Gruppo 3"
E dovrei non vedere "Gruppo 4"
Quando seleziono la casella "Gruppo 1"
E seleziono la casella "Gruppo 3"
Quando premo "Invia annuncio ai gruppi"
Allora dovrei vedere "Annuncio inviato a 2 indirizzi"
E il sistema ha inviato 1 email

Scenario: Non seleziono gruppo
Dato mi loggo con email "paolino@nomail.it" e password "12345678"
Dato che esistono i seguenti gruppi di "paolino@nomail.it":
| name                  | description               |
| Gruppo 1              | Un grande gruppo          |
| Gruppo 2              | Un altro gruppo           |
E vado alla pagina di nuovo annuncio per "Campionato"
Quando deseleziono la casella "Gruppo 1"
E deseleziono la casella "Gruppo 2"
E premo "Invia annuncio ai gruppi"
Allora dovrei vedere "Non sono stati inseriti gruppi"

@email
Scenario: Invio mail di annuncio a uno o più utenti
Dato mi loggo con email "paolino@nomail.it" e password "12345678"
E vado alla pagina di nuovo annuncio per "Campionato"
Quando seleziono la casella "Pluto"
E seleziono la casella "Paperoga"
Quando premo "Invia annuncio a questi utenti"
Allora dovrei vedere "Annuncio inviato a 2 indirizzi"
E il sistema ha inviato 1 email


Scenario: Non seleziono utenti
Dato mi loggo con email "paolino@nomail.it" e password "12345678"
E vado alla pagina di nuovo annuncio per "Campionato"
Quando deseleziono la casella "Pluto"
E deseleziono la casella "Paperoga"
E premo "Invia annuncio a questi utenti"
Allora dovrei vedere "Non sono stati inseriti utenti"


