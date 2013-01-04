#language: it

Funzionalità: Gestione eventi
Come utente
Voglio vedere al massimo 5 eventi nella mia home page
Per evitare che la pagina sia troppo piena

Contesto: Situazione iniziale
Dato   che esistono i seguenti utenti:
| name                  | email                 | password  |
| Paperino              | paolino@nomail.it     | 12345678  |


Scenario:   Limita la visualizzazione degli eventi organizzati a 5 soltanto
E che ci sono 7 eventi di "paolino@nomail.it"
E che esistono i seguenti eventi dell'utente "paolino@nomail.it":
| name                  | system     | begins_at   |
| Ultimo                | Risiko     | 10-12-2014  |
E vado al profilo dell'utente "paolino@nomail.it"
Allora dovrei vedere "ed altri 3" all'interno di "p"
E dovrei non vedere "Ultimo"
E dovrei vedere "Eventi organizzati (8)" all'interno di "a"

Scenario:   Limita la visualizzazione degli eventi prenotati a 5 soltanto
E che esistono i seguenti eventi dell'utente "paolino@nomail.it":
| name                  | system     | begins_at  |
| Primo                 | Risiko     | 10-5-2013  |
| Secondo               | Monopoli   | 21-7-2013  |
| Terzo                 | Risiko     | 10-12-2014 |
| Quarto                | Monopoli   | 21-7-2013  |
| Quinto                | Risiko     | 10-12-2014 |
| Sesto                 | Risiko     | 10-12-2014 |
E che esiste la prenotazione dell'evento "Primo" per l'utente "paolino@nomail.it"
E che esiste la prenotazione dell'evento "Secondo" per l'utente "paolino@nomail.it"
E che esiste la prenotazione dell'evento "Terzo" per l'utente "paolino@nomail.it"
E che esiste la prenotazione dell'evento "Quarto" per l'utente "paolino@nomail.it"
E che esiste la prenotazione dell'evento "Quinto" per l'utente "paolino@nomail.it"
E che esiste la prenotazione dell'evento "Sesto" per l'utente "paolino@nomail.it"
E vado al profilo dell'utente "paolino@nomail.it"
Allora dovrei vedere "ed altri 1" all'interno di "p"
E dovrei non vedere "Sesto"
E dovrei vedere "Eventi prenotati (6)" all'interno di "a"


