# language: it

Funzionalità:
Come utente
voglio avere una lista chiara dei miei eventi
perché posso organizzarmi meglio

Contesto: Situazione iniziale
Dato   che esistono i seguenti utenti:
| name                  | email                 | password  |
| Paperino              | paolino@nomail.it     | 12345678  |


Scenario: Mostra gli eventi dell'utente
Dato ci sono 3 eventi di "paolino@nomail.it"
E vado al profilo dell'utente "paolino@nomail.it"
E seguo il link "Eventi organizzati (3)"
* mostra la pagina




