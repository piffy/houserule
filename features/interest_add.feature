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



