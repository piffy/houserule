# language: it
Funzionalità: Modifica interesse a un gruppo
Come utente interessato a un gruppo
Voglio potere modificare o cancellare la mia iscrizione
Per far sapere i miei interessi

Contesto:
Dato   che esistono i seguenti utenti:
| name                  | email                 | password  | password_confirmation | nick | location   |  description |
| Paperino              | paolino@nomail.it     | 12345678  | 12345678              | pap  | Paperopoli |  Papero      |
| Pippo                 | pippo@nomail.it       | 12345678  | 12345678              | pip  | Paperopoli |  Papero      |
| Paperoga              | paperoga@nomail.it    | 12345678  | 12345678              | pip  | Paperopoli |  Papero      |


E che esistono i seguenti gruppi di "paolino@nomail.it":
| name                  | description               |
| Gruppo 1              | Un grande gruppo          |


Scenario: Modifica standard
Dato mi loggo con email "pippo@nomail.it" e password "12345678"
Dato a "Pippo" interessa il gruppo "Gruppo 1"
Quando vado alla modifica interesse di "Gruppo 1" per "Pippo"
Allora dovrei vedere il titolo "Modifica interesse"
Quando deseleziono la casella "interest_is_visible"
E deseleziono la casella "interest_gets_email"
Quando premo "Confermo"
Allora dovrei vedere "Pippo" all'interno di "a"
E dovrei non vedere "" all'interno di "i.icon-eye-open"
E dovrei non vedere "" all'interno di "i.icon-envelope"


Scenario: Bannare utente
Dato mi loggo con email "paolino@nomail.it" e password "12345678"
Dato a "Pippo" interessa il gruppo "Gruppo 1"
Dato vado alla visualizzazione gruppo di "Gruppo 1"
Quando vado alla modifica interesse di "Gruppo 1" per "Pippo"
Allora dovrei vedere il titolo "Modifica interesse"
Quando seleziono la casella "interest_is_banned"
Quando premo "Confermo"
Allora dovrei vedere "Pippo" all'interno di "a"
E dovrei vedere "" all'interno di "i.icon-fire"


Scenario: Utente non autorizzato
Dato mi loggo con email "paperoga@nomail.it" e password "12345678"
Dato a "Pippo" interessa il gruppo "Gruppo 1"
Quando vado alla modifica interesse di "Gruppo 1" per "Pippo"
Allora  dovrei vedere "Azione non consentita"


Scenario: Utente bannato non può fare modifiche
Dato mi loggo con email "pippo@nomail.it" e password "12345678"
Dato "Pippo" è bannato dal gruppo "Gruppo 1"
Quando vado alla modifica interesse di "Gruppo 1" per "Pippo"
Allora  dovrei vedere "Sei stato bannato"


Scenario: Elimina interesse
Dato mi loggo con email "pippo@nomail.it" e password "12345678"
Dato a "Pippo" interessa il gruppo "Gruppo 1"
Quando vado alla modifica interesse di "Gruppo 1" per "Pippo"
Allora dovrei vedere il titolo "Modifica interesse"
E      dovrei vedere "eliminare" all'interno di "a"
#Non testabile con capybara
#E il sistema ha inviato 1 email
#E dovrei vedere "Mail inviata all'organizzatore"


