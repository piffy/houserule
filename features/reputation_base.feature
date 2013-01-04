#language: it

Funzionalità: elenco reputazioni
Come utente braghero
Voglio vedere l'elenco della reputazione dei giocatori
Per avere un'idea dei miei compagni di gioco

Contesto: Situazione iniziale


Scenario:  elenco reputazioni
Dato che ci sono 10 utenti
Dato tutti gli utenti hanno una reputazione
Dato mi trovo nella pagina di elenco reputazioni
Allora dovrei vedere il titolo "Reputazioni"
E dovrei non vedere "Resetta" all'interno di "a"
E dovrei non vedere "Modifica" all'interno di "a"

Scenario: se non loggato, vai al login
Dato che ci sono 1 utenti
Dato tutti gli utenti hanno una reputazione
Quando mi trovo nella pagina di modifica reputazione di un utente
Allora dovrei essere nella pagina di login

Scenario: se l'utente non è amministratore, segnala errore
Dato che ci sono 1 utenti
Dato tutti gli utenti hanno una reputazione
Dato   che esistono i seguenti utenti:
| name                  | email                 | password  |
| Paperino              | paolino@nomail.it     | 12345678  |
E mi loggo con email "paolino@nomail.it" e password "12345678"
Quando mi trovo nella pagina di modifica reputazione di un utente
Allora dovrei vedere "Azione non consentita"

Scenario: L'utente amministratore può modificare la rep
Dato che ci sono 1 utenti
Dato tutti gli utenti hanno una reputazione
Dato esiste l'utente amministratore "admin@houserule.it"
E mi loggo con email "admin@houserule.it" e password "foobar"
Quando mi trovo nella pagina di elenco reputazioni
Allora dovrei vedere "Resetta" all'interno di "a"
E dovrei vedere "Modifica" all'interno di "a"
Quando mi trovo nella pagina di modifica reputazione di un utente
E inserisco in "reputation_participations" "1"
E inserisco in "reputation_organized" "1"
E inserisco in "reputation_archived" "1"
E inserisco in "reputation_positive_fb" "1"
E inserisco in "reputation_negative_fb" "1"
E premo "Modifica"
Allora dovrei vedere "3" all'interno di "b#reputation_score"


Scenario: Visualizza reputazione
Dato che esistono i seguenti utenti:
| name                  | email                 | password  |
| Paperino              | paolino@nomail.it     | 12345678  |
Quando vado al profilo dell'utente "paolino@nomail.it"
Allora dovrei vedere "N/A" all'interno di "#reputation_score"
Dato tutti gli utenti hanno una reputazione
Quando vado al profilo dell'utente "paolino@nomail.it"
E dovrei vedere "Reputazione" all'interno di "a"

Scenario: Attiva reputazione (solo stesso utente o admin)
Dato esistono i seguenti utenti:
| name                  | email                 | password  |
| Paperino              | paolino@nomail.it     | 12345678  |
E mi loggo con email "paolino@nomail.it" e password "12345678"
Quando vado al profilo dell'utente "paolino@nomail.it"
Allora dovrei vedere "N/A" all'interno di "#reputation_score"
E dovrei vedere il pulsante "Attiva"
Quando premo "Attiva"
Allora dovrei vedere "Sistema di reputazione attivato"
E dovrei vedere "0" all'interno di "#reputation_score"
