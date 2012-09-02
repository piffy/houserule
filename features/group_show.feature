#language: it
Funzionalità: Visualizzare i dati di un gruppo
Come giocatore
Voglio poter vedere i dettagli e gli interessati ai gruppi esistenti
Per decidere se iscrivermi o disiscrivermi


Contesto:
Dato   che esistono i seguenti utenti:
| name                  | email                 | password  | password_confirmation | nick | location   |  description |
| Paperino              | paolino@nomail.it     | 12345678  | 12345678              | pap  | Paperopoli |  Papero      |
| Pippo                 | pippo@nomail.it       | 12345678  | 12345678              | gof  | Topolinia  |  Cane        |
| Paperoga              | paperoga@nomail.it    | 12345678  | 12345678              | rog  | Paperopoli |  Papero      |


E che esistono i seguenti gruppi di "paolino@nomail.it":
| name                  | description               |
| Gruppo 1              | Un grande gruppo          |
| Gruppo 2              | Un altro gruppo           |

Scenario: Mostra i dati principali
Dato    vado alla visualizzazione gruppo di "Gruppo 1"
Allora dovrei vedere il titolo "Dettagli gruppo"
E dovrei vedere "Paperino" all'interno di "a#group_owner"
E dovrei vedere "0" all'interno di "span#member_count"
E dovrei vedere "Un grande gruppo" all'interno di "p#description"
E dovrei vedere "Mi interessa" all'interno di "a.btn"
E dovrei non vedere "Modifica" all'interno di "a.btn"

Scenario: Mostra gli iscritti standard
Dato a "Pippo" interessa il gruppo "Gruppo 1"
E    a "Paperoga" interessa il gruppo "Gruppo 1"
Quando vado alla visualizzazione gruppo di "Gruppo 1"
E dovrei vedere "Paperino" all'interno di "a#group_owner"
E dovrei vedere "2" all'interno di "span#member_count"
E dovrei vedere "Pippo" all'interno di "a"
E dovrei vedere "Paperoga" all'interno di "a"

Scenario: Non mostrare gli iscritti non standard
Dato "Pippo" è bannato dal gruppo "Gruppo 1"
E    "Paperoga" è invisibile nel gruppo "Gruppo 1"
Quando vado alla visualizzazione gruppo di "Gruppo 1"
E dovrei vedere "Paperino" all'interno di "a#group_owner"
E dovrei vedere "2" all'interno di "span#member_count"
E dovrei non vedere "Paperoga" all'interno di "a"
E dovrei non vedere "Pippo" all'interno di "a"

Scenario: Mostrare tutti gli iscritti (come responsabile)
Dato "Pippo" è bannato dal gruppo "Gruppo 1"
E    "Paperoga" è invisibile nel gruppo "Gruppo 1"
Dato mi loggo con email "paolino@nomail.it" e password "12345678"
Quando vado alla visualizzazione gruppo di "Gruppo 1"
Allora dovrei vedere "Paperino" all'interno di "a#group_owner"
E dovrei vedere "2" all'interno di "span#member_count"
E dovrei vedere "Paperoga" all'interno di "a"
E dovrei vedere "Pippo" all'interno di "a"
E dovrei vedere "Modifica" all'interno di "a.btn"

Scenario: Mostra la mia iscrizione (anche se bannato)
Dato "Pippo" è bannato dal gruppo "Gruppo 1"
Dato mi loggo con email "pippo@nomail.it" e password "12345678"
Quando vado alla visualizzazione gruppo di "Gruppo 1"
Allora dovrei vedere "Paperino" all'interno di "a#group_owner"
E dovrei vedere "1" all'interno di "span#member_count"
E dovrei vedere "Pippo" all'interno di "a"
E dovrei non vedere "Non m'interessa più" all'interno di "a.btn"
E dovrei vedere "Sei stato bandito da questo gruppo"

Scenario: Mostra la mia iscrizione (anche se invisibile)
Dato "Pippo" è invisibile nel gruppo "Gruppo 1"
Dato mi loggo con email "pippo@nomail.it" e password "12345678"
Quando vado alla visualizzazione gruppo di "Gruppo 1"
Allora dovrei vedere "Paperino" all'interno di "a#group_owner"
E dovrei vedere "1" all'interno di "span#member_count"
E dovrei vedere "Pippo" all'interno di "a"
E dovrei vedere "Non m'interessa più" all'interno di "a.btn"

Scenario: Elenco dei gruppi creati nel profilo utente
E mi loggo con email "paolino@nomail.it" e password "12345678"
Quando vado al profilo dell'utente "paolino@nomail.it"
Allora dovrei vedere "Gruppo 1" all'interno di "li"
E dovrei vedere "Gruppo 1" all'interno di "li"
Allora dovrei vedere "2" all'interno di "span#group_count"
E dovrei vedere "" all'interno di "i.icon-edit"

Scenario: Elenco dei gruppi che interessano nel profilo utente
Dato a "Pippo" interessa il gruppo "Gruppo 1"
Dato mi loggo con email "pippo@nomail.it" e password "12345678"
Quando vado al profilo dell'utente "pippo@nomail.it"
Allora dovrei vedere "Gruppo 1" all'interno di "li"
Allora dovrei vedere "1" all'interno di "span#group_count"


