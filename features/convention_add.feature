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


  Scenario:   Creazione gruppo (happy path)
    Dato mi loggo con email "paolino@nomail.it" e password "12345678"
    E      mi trovo nella pagina di creazione gruppo
    Quando inserisco in "convention_name" "Un nome"
    E      inserisco in "convention_description" "Una descrizione"
    Quando premo "Invia"
    Allora  dovrei essere nella pagina di dettagli della convention "Un nome"
    E dovrei vedere "Convention creata"
    E dovrei vedere "Paperino" all'interno di "a#convention_owner"

  Scenario:  Non inserisco il nome
    Dato mi loggo con email "paolino@nomail.it" e password "12345678"
    E      mi trovo nella pagina di creazione convention
    Quando premo "Invia"
    E dovrei vedere il messaggio di errore "Il nome non può essere lasciato in bianco"


  Scenario:   Aggiungere convention (redirect amichevole)
    Dato     mi trovo nella pagina di creazione convention
    Allora dovrei essere nella pagina di login
    Quando mi loggo con email "paolino@nomail.it" e password "12345678"
    Allora dovrei essere nella pagina di creazione gruppo

  Scenario:   Aggiungere convention (nome duplicato)
    Dato mi loggo con email "paolino@nomail.it" e password "12345678"
    Dato     mi trovo nella pagina di creazione convention
    Quando inserisco in "convention_name" "Un nome"
    Quando premo "Invia"
    Allora  dovrei essere nella pagina di dettagli del gruppo "Un nome"
    Dato     mi trovo nella pagina di creazione convention
    Quando inserisco in "convention_name" "Un nome"
    Quando premo "Invia"
    Allora dovrei vedere il messaggio di errore "Nome è già in uso"

