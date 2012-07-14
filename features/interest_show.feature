#language: it
Funzionalità: Visualizzare i memberi di un gruppo
Come giocatore
Voglio poter vedere chi fa parte di un gruppo
Per decidere se mi interessa

Contesto:
Dato   che esistono i seguenti utenti:
| name                  | email                 | password  | password_confirmation | nick | location   |  description |
| Paperino              | paolino@nomail.it     | 12345678  | 12345678              | pap  | Paperopoli |  Papero      |
| Pippo                 | pippo@nomail.it       | 12345678  | 12345678              | pip  | Paperopoli |  Papero      |
| Pluto                 | pluto@nomail.it       | 12345678  | 12345678              | plu  | Paperopoli |  Cane      |
| Paperoga              | paperoga@nomail.it    | 12345678  | 12345678              | rog  | Paperopoli |  Papero      |


E che esistono i seguenti gruppi di "paolino@nomail.it":
| name                  | description               |
| Gruppo 1              | Un grande gruppo          |

E che esistono i seguenti gruppi di "paperoga@nomail.it":
| name                  | description               |
| Gruppo roga           | Un altro gruppo           |


Scenario: Elenco iscritti a un gruppo (no login)
Dato che i seguenti utenti sono interessati al gruppo "Gruppo 1"
| user_name               | is_visible | is_banned | gets_email |
| Pippo                   | 1          | 0         | 1          |
| Pluto                   | 0          | 0         | 1          |
| Paperoga                | 0          | 0         | 1          |
E    vado alla visualizzazione gruppo di "Gruppo 1"
Allora dovrei vedere "Pippo" all'interno di "a"
E dovrei non vedere "Pluto" all'interno di "a"
E dovrei non vedere "Paperoga" all'interno di "a"

Scenario: Elenco iscritti a un gruppo (come responsabile)
Dato che ci sono 3 gruppi di "paolino@nomail.it"
E che i seguenti utenti sono interessati al gruppo "Gruppo 1"
| user_name               | is_visible | is_banned | gets_email |
| Pippo                   | 1          | 0         | 1          |
| Pluto                   | 0          | 0         | 1          |
| Paperoga                | 0          | 0         | 1          |
Dato mi loggo con email "paolino@nomail.it" e password "12345678"
E vado alla pagina di elenco gruppo
Dato    vado alla visualizzazione gruppo di "Gruppo 1"
Allora dovrei vedere "Paperino" all'interno di "span#group_owner"
Allora dovrei vedere "Pippo" all'interno di "a"
E dovrei vedere "Pluto" all'interno di "a"
E dovrei vedere "Paperoga" all'interno di "a"

Scenario: Elenco iscritti a un gruppo (come già interessato)
E che i seguenti utenti sono interessati al gruppo "Gruppo 1"
| user_name               | is_visible | is_banned | gets_email |
| Pippo                   | 1          | 0         | 1          |
| Pluto                   | 0          | 0         | 1          |
| Paperoga                | 0          | 0         | 1          |
Dato mi loggo con email "pluto@nomail.it" e password "12345678"
Dato    vado alla visualizzazione gruppo di "Gruppo 1"
Allora dovrei vedere "Paperino" all'interno di "span#group_owner"
Allora dovrei vedere "Pippo" all'interno di "a"
E dovrei vedere "Pluto" all'interno di "a"
#E dovrei non vedere "Paperoga" all'interno di "a"
* mostra la pagina

Scenario: Elenco dei gruppi creati nel profilo utente
E mi loggo con email "paolino@nomail.it" e password "12345678"
Quando vado al profilo dell'utente "paolino@nomail.it"
Allora dovrei vedere "Gruppo 1" all'interno di "li"
E dovrei vedere "Gestisci" all'interno di "a"

Scenario: Elenco dei gruppi che interessano nel profilo utente
Dato mi loggo con email "pluto@nomail.it" e password "12345678"
Quando vado al profilo dell'utente "pluto@nomail.it"
#Allora dovrei vedere "Gruppo 1" all'interno di "li"
#E dovrei vedere "Modifica" all'interno di "a"




