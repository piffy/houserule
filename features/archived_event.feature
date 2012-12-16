# language: it

Funzionalità:
Come organizzatore di evento
voglio che un evento completato sia tolto dall'elenco degli eventi visibili
perché non è interessante

Contesto:
Dato   che esistono i seguenti utenti:
| name                  | email                 | password  | password_confirmation | nick | location   |  description |
| Paperino              | paolino@nomail.it     | 12345678  | 12345678              | pap  | Paperopoli |  Papero      |
| Pluto                 | pluto@nomail.it       | 12345678  | 12345678              |      | Topolinia  |  Cane        |


E che esistono i seguenti eventi dell'utente "paolino@nomail.it":
| name                  | system             | begins_at  |  deadline |
| Campionato            | Risiko             | 10-5-2013  | 9-5-2013  |
| Passato               | Yahzee             | 10-5-2012  | 9-5-2012  |

E mi loggo con email "paolino@nomail.it" e password "12345678"

Scenario:  Mostra pulsante "archivia" se l'evento è già iniziato
Dato vado alla visualizzazione evento di "Passato"
Allora dovrei vedere "Archivia" all'interno di "a"


Scenario: Non mostra il pulsante "archivia" se l'evento non è iniziato
Dato che esiste l'invito all'evento "Campionato" per l'utente "pluto@nomail.it"
E che esiste la prenotazione dell'evento "Campionato" per l'utente "paolino@nomail.it"
Dato vado alla visualizzazione evento di "Campionato"
Allora dovrei non vedere "Archivia" all'interno di "a"


Scenario: Mostra archivia dalla pagina finale di editing


Scenario: Archiviazione di un evento
Dato che esiste la prenotazione dell'evento "Passato" per l'utente "paolino@nomail.it"
E vado alla archiviazione evento di "Passato"
Allora dovrei vedere il titolo "Archivia"
Quando premo "Archivia"
Allora dovrei non vedere "Deadline"
E dovrei non vedere "Inviti"
E dovrei vedere "Archiviato il"
E dovrei non vedere "Iniziato"
E dovrei vedere "Paperino"
E dovrei non vedere "Modifica Evento"


Scenario: un amministratore può de-archiviare un evento

Scenario: un amministratore può cancellare  un evento






