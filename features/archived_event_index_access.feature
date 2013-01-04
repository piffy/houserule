# language: it

Funzionalità:
Come utente
voglio poter consultare l'elenco degli eventi archiviato
perché vogli trarre delle ispirazioni

Contesto: Descrizione

Contesto:
Dato   che esistono i seguenti utenti:
| name                  | email                 | password  |
| Paperino              | paolino@nomail.it     | 12345678  |
| Pluto                 | pluto@nomail.it       | 12345678  |

E ci sono 3 eventi di "paolino@nomail.it"
E ci sono 2 eventi archiviati di "pluto@nomail.it"

Scenario:  Indice eventi archiviati
Dato mi trovo nella pagina di elenco eventi
Quando scelgo "selection_archived"
E premo "Aggiorna"
Allora dovrei vedere il titolo "Eventi (archiviati)"
E dovrei vedere "Archived"
Quando scelgo "selection_all_events"
E premo "Aggiorna"
Allora dovrei non vedere "Archived"
E dovrei vedere "Event 1"

Scenario:  Impossibile archiviare se non loggato
Dato mi trovo nella pagina di elenco eventi
Quando archivio un evento
Allora dovrei essere nella pagina di login

Scenario:  Impossibile archiviare o modificare  se non ho i diritti
E mi loggo con email "pluto@nomail.it" e password "12345678"
Quando archivio un evento
Allora dovrei vedere "Azione non consentita"
Quando vado alla modifica di un evento archiviato
Allora dovrei vedere "Azione non consentita"
E dovrei essere nella home page

Scenario:  Archiviazione possibile se amministratore
Dato esiste l'utente amministratore "admin@houserule.it"
E mi loggo con email "admin@houserule.it" e password "foobar"
Quando archivio un evento
Allora dovrei vedere il titolo "Archivia"

Scenario:  Modifica commento se amministratore
Dato esiste l'utente amministratore "admin@houserule.it"
E mi loggo con email "admin@houserule.it" e password "foobar"
Quando vado alla modifica di un evento archiviato
Allora dovrei vedere il titolo "Modifica evento"
Quando inserisco in "archived_event_aftermath" "Un nuovo commento"
E premo "Aggiorna"
Allora dovrei vedere "con successo"
E dovrei vedere "Un nuovo commento"












