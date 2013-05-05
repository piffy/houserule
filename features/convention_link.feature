# language: it

Funzionalità:
  Come partecipante ad una convention
  voglio poter proporre un evento
  perché sia visibile nel programma

  Contesto:


    Dato   che esistono i seguenti utenti:
      | name                  | email                 | password  |
      | Paperino              | paolino@nomail.it     | 12345678  |
      | Pippo                 | pippo@nomail.it       | 12345678  |

    Dato   che esistono le seguenti convention:
      | name                  | location              | begin_date  | end_date   |
      | First                 | Rimini                | 12-04-2016  | 12-04-2016 |
      | Before                | A better place        | 12-04-2016  | 11-06-2016 |
      | Christmas             | Home                  | 25-12-2013  | 25-12-2013 |

Scenario: Proposta inserimento evento a partire dalla pagina della convention
  Dato mi loggo con email "pippo@nomail.it" e password "12345678"
  E    vado alla pagina di visualizzazione di una convention
  Allora dovrei vedere "Proponi evento" all'interno di "a"
  Quando seguo il link "Proponi evento"
  Allora dovrei vedere il titolo "Proponi evento"
  E dovrei vedere "proposto per essere inserito"
  Quando inserisco in "event_name" "Evento della con"
  E      inserisco in "event_description" "Uno scenario superbo"
  E      inserisco in "event_descr_short" "partita"
  E premo "Prossimo"
  Allora dovrei vedere "Evento creato!"
  Quando premo "Prossimo"
  Allora il campo "event_location" dovrebbe contenere "Rimini"
  E il campo "event_begins_at_date_only" dovrebbe contenere "12-04-2016"
  E il campo "event_deadline_date_only" dovrebbe contenere "12-04-2016"
  E vado alla visualizzazione evento di "Evento della con"
  Allora dovrei vedere "First"
  Quando vado alla pagina di visualizzazione di una convention
  Allora dovrei vedere "Evento della con"


Scenario: Proposta inserimento evento a partire da un evento già esistente
  Dato che esistono i seguenti eventi dell'utente "pippo@nomail.it":
    | name                     | system        | begins_at  |
    | Full event               | Yahtzee       | 12-04-2016  |
  E mi loggo con email "pippo@nomail.it" e password "12345678"
  E vado alla visualizzazione evento di "Full event"
  Allora dovrei vedere "Proponi per convention" all'interno di "a"
  Quando seguo il link "Proponi per convention"
  Allora dovrei vedere il titolo "Proposta inserimento conventio"
  E dovrei vedere "First"
  E dovrei non vedere "Christmas"
  Quando premo il pulsante "Proponi"
  Allora dovrei vedere "Evento proposto per la convention"
  Allora dovrei vedere "First" all'interno di "h1"
  Allora dovrei vedere "Full event" all'interno di "a"

Scenario: Approvazione evento (da parte dell'organizzatore della Con)
  Dato che ci sono 1 eventi di "pippo@nomail.it"
  E un evento compatibile attende l'approvazione per una convention
  E mi loggo con email "paolino@nomail.it" e password "12345678"
  Quando vado alla pagina di visualizzazione di una convention
  Allora dovrei vedere "Approva" all'interno di "a"
  Quando seguo il link "Approva"
  Allora dovrei vedere "Evento confermato"
  Quando vado alla pagina di visualizzazione di una convention
  Allora dovrei vedere "Event 1"
  E dovrei vedere "(C)" all'interno di "abbr"
  Quando vado ai dettagli di un evento
  Allora dovrei vedere "First"

Scenario: Disapprovazione evento proposto (da parte dell'organizzatore della Con)
  Dato che ci sono 1 eventi di "pippo@nomail.it"
  E un evento compatibile attende l'approvazione per una convention
  E mi loggo con email "paolino@nomail.it" e password "12345678"
  Quando vado alla pagina di visualizzazione di una convention
  Allora dovrei vedere "Approva" all'interno di "a"
  E dovrei vedere "Rifiuta" all'interno di "a"
  Quando seguo il link "Rifiuta"
  Allora dovrei vedere "Evento rimosso dal programma"
  Quando vado alla pagina di visualizzazione di una convention
  Allora dovrei non vedere "Event 1"
  Quando vado ai dettagli di un evento
  Allora dovrei vedere "Proposto"

Scenario: Disapprovazione evento confermato (da parte dell'organizzatore della Con)
  Dato che ci sono 1 eventi di "pippo@nomail.it"
  E un evento compatibile attende l'approvazione per una convention
  E l'evento è stato confermato
  E mi loggo con email "paolino@nomail.it" e password "12345678"
  Quando vado alla pagina di visualizzazione di una convention
  Allora dovrei non vedere "Approva" all'interno di "a"
  E dovrei vedere "Rimuovi" all'interno di "a"
  Quando seguo il link "Rimuovi"
  Allora dovrei vedere "Evento rimosso dal programma"
  Quando vado alla pagina di visualizzazione di una convention
  Allora dovrei non vedere "Event 1"
  Quando vado ai dettagli di un evento
  Allora dovrei vedere "Proposto"

Scenario: Disapprovazione evento (da parte dell'organizzatore dell'evento)
  Dato che ci sono 1 eventi di "pippo@nomail.it"
  E un evento compatibile attende l'approvazione per una convention
  E l'evento è stato confermato
  Quando mi loggo con email "pippo@nomail.it" e password "12345678"
  E vado alla modifica di un evento
  E seguo il link "Rimuovi dal programma"
  Allora dovrei vedere "Evento rimosso dal programma"
  Quando vado alla pagina di visualizzazione di una convention
  Allora dovrei non vedere "Event 1"
  Quando vado ai dettagli di un evento
  Allora dovrei vedere "Proposto"


Scenario: Un evento approvato non può modificare gli orari
  Dato che ci sono 1 eventi di "pippo@nomail.it"
  E un evento compatibile attende l'approvazione per una convention
  E l'evento è stato confermato
  E mi loggo con email "pippo@nomail.it" e password "12345678"
  Quando vado alla modifica di un evento
  E premo il pulsante "Prossimo"
  E premo il pulsante "Prossimo"
  Allora dovrei vedere il campo "event_location"
  Allora dovrei non vedere il campo "event_begins_at_date_only"

Scenario: Un evento legato a una torna allo stato normale se la con viene distrutta
  Dato che ci sono 1 eventi di "pippo@nomail.it"
  E un evento compatibile attende l'approvazione per una convention
  E l'evento è stato confermato
  Quando la convention viene distrutta
  E vado ai dettagli di un evento
  Allora dovrei vedere "Proposto"


