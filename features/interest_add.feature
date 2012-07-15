# language: it
Funzionalità: Iscrizione a un gruppo
Come utente registrato
Voglio potere registrarmi in un gruppo di mio interesse
Per ricevere informazioni su quel gruppo


Contesto:
Dato   che esistono i seguenti utenti:
| name                  | email                 | password  | password_confirmation | nick | location   |  description |
| Paperino              | paolino@nomail.it     | 12345678  | 12345678              | pap  | Paperopoli |  Papero      |
| Pippo                 | pippo@nomail.it       | 12345678  | 12345678              | goofy | Topolinia |  Cane        |

E che esistono i seguenti gruppi di "paolino@nomail.it":
| name                  | description               |
| Gruppo 1              | Un grande gruppo          |

Dato mi loggo con email "pippo@nomail.it" e password "12345678"
E    vado alla visualizzazione gruppo di "Gruppo 1"

Scenario: Iscrizione a un gruppo (happy path)
Dato dovrei vedere "Mi interessa" all'interno di "a"
Quando seguo il link "Mi interessa"
Allora dovrei vedere il titolo "Segnala interesse"
Quando premo "Confermo"
Allora dovrei vedere il titolo "Dettagli gruppo"
E dovrei vedere "Pippo" all'interno di "a"
E dovrei vedere "" all'interno di "i.icon-eye-open"
E dovrei vedere "" all'interno di "i.icon-envelope"

Scenario: Iscrizione vietata al proprio un gruppo
Dato che esistono i seguenti gruppi di "pippo@nomail.it":
| name                  | description               |
| Gruppo 2              | Un piccolo gruppo         |
E    vado alla visualizzazione gruppo di "Gruppo 2"
Quando vado alla iscrizione gruppo di "Gruppo 2"
Quando premo "Confermo"
Allora dovrei essere nella pagina di dettagli del gruppo "Gruppo 2"
E dovrei vedere "Non puoi interessarti al tuo gruppo"
E dovrei non vedere "Mi interessa"

Scenario: Iscrizione senza opzione email
Dato dovrei vedere "Mi interessa" all'interno di "a"
Quando seguo il link "Mi interessa"
Allora dovrei vedere il titolo "Segnala interesse"
Quando deseleziono la casella "interest_gets_email"
Quando premo "Confermo"
Allora dovrei vedere il titolo "Dettagli gruppo"
E dovrei vedere "Pippo" all'interno di "a"
E dovrei vedere "" all'interno di "i.icon-eye-open"
E dovrei non vedere "" all'interno di "i.icon-envelope"

Scenario: Iscrizione senza opzione visibile
Dato dovrei vedere "Mi interessa" all'interno di "a"
Quando seguo il link "Mi interessa"
Allora dovrei vedere il titolo "Segnala interesse"
Quando deseleziono la casella "interest_is_visible"
Quando premo "Confermo"
Allora dovrei vedere il titolo "Dettagli gruppo"
E dovrei vedere "Pippo" all'interno di "a"
E dovrei non vedere "" all'interno di "i.icon-eye-open"
E dovrei vedere "" all'interno di "i.icon-envelope"
