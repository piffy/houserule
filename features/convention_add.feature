# language: it


Funzionalità: Creazione convention
  Come organizzatore
  Voglio potermi creare una nuova convention
  Per raggruppare e organizzare gli eventi ad essa relativi

  Contesto:
    Dato   che esistono i seguenti utenti:
      | name                  | email                 | password  | password_confirmation | nick | location   |  description |
      | Paperino              | paolino@nomail.it     | 12345678  | 12345678              | pap  | Paperopoli |  Papero      |


  Scenario:   Raggiungere la pagine di creazione convention
    Dato mi loggo con email "paolino@nomail.it" e password "12345678"
    E    mi trovo nella pagina di creazione convention
    Allora dovrei vedere il titolo "Creazione convention"

  Scenario:   Raggiungere la pagine di creazione convention con navigazione

  Scenario:   Creazione convention (happy path)
    Dato mi loggo con email "paolino@nomail.it" e password "12345678"
    E      mi trovo nella pagina di creazione convention
    Quando inserisco in "convention_name" "Una Convention"
    E      inserisco in "convention_begin_date_only" "21-12-2013"
    E      inserisco in "convention_end_date_only" "23-12-2013"
    E      inserisco in "convention_location" "A very good place"
    Quando premo "Invia"
    E dovrei vedere "Convention creata"
    E dovrei vedere "Una Convention"

  Scenario:  Non inserisco il nome
    Dato mi loggo con email "paolino@nomail.it" e password "12345678"
    E      mi trovo nella pagina di creazione convention
    Quando premo "Invia"
    E dovrei vedere il messaggio di errore "Name non deve essere vuoto"


  Scenario:  Non inserisco il luogo
    Dato mi loggo con email "paolino@nomail.it" e password "12345678"
    E      mi trovo nella pagina di creazione convention
    Quando inserisco in "convention_name" "Una Convention"
    Quando premo "Invia"
    E dovrei vedere il messaggio di errore "Location non deve essere vuoto"


  Scenario:   Aggiungere convention (redirect amichevole)
    Dato     mi trovo nella pagina di creazione convention
    Allora dovrei essere nella pagina di login
    Quando mi loggo con email "paolino@nomail.it" e password "12345678"
    Allora dovrei vedere il titolo "Creazione convention"

  Scenario:   Aggiungere convention (nome duplicato)
    Dato mi loggo con email "paolino@nomail.it" e password "12345678"
    Dato     mi trovo nella pagina di creazione convention
    Quando inserisco in "convention_name" "Un nome"
    E      inserisco in "convention_location" "A very good place"
    Quando premo "Invia"
    Allora  dovrei essere nella pagina di dettagli di una convention
    Dato     mi trovo nella pagina di creazione convention
    Quando inserisco in "convention_name" "Un nome"
    E      inserisco in "convention_location" "A better place"
    Quando premo "Invia"
    Allora dovrei vedere il messaggio di errore "Name in uso"
