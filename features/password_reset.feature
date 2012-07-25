#language: it

Funzionalità: Reset delle password
Come utente registrato
Voglio resettare la password
Per accedere senza dover riregistrarmi

Contesto:
Dato   esistono i seguenti utenti:
| name                  | email                 | password  |
| Paperino              | paolino@nomail.it     | 12345678  |

Scenario: Password dimenticata
Dato   mi trovo nella pagina di login
E      non sono loggato come utente "Paperino"
Allora dovrei vedere "dimenticato la password?"
Quando seguo il link "dimenticato la password?"
Allora dovrei vedere il titolo "Password dimenticata"
Dato inserisco in "password_reset_email" "paolino@nomail.it"
Quando premo "Invia email per la password"
Allora dovrei essere nella home page
E dovrei vedere "mail di reimpostazione password inviata a paolino@nomail.it"
Allora dovrebbe spedire una mail di reset password a "paolino@nomail.it"
E l'ultima mail dovrebbe contenere "paolino@nomail.it"
E l'ultima mail dovrebbe contenere il link di reset per "paolino@nomail.it"
Quando seguo il link dell'ultima mail
Allora dovrei vedere il titolo "Cambio password"
Dato inserisco in "password_reset_password" "11111111"
Dato inserisco in "password_reset_password_confirmation" "11111111"
Quando premo "Reimposta password"
Allora dovrei essere nella pagina di login
E dovrei vedere "La password è stata aggiornata"
Quando inserisco in "session_email" "paolino@nomail.it"
E      inserisco in "session_password" "11111111"
Quando premo "Login"
Allora dovrei vedere "Profilo di Paperino"


Scenario: No account
Dato   mi trovo nella pagina di login
E seguo il link "dimenticato la password?"
Dato inserisco in "password_reset_email" "error@nomail.it"
Quando premo "Invia email per la password"
E dovrei vedere "Email o password errata"


Scenario: Link scaduto
