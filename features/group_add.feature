# language: it


Funzionalità: Creazione gruppo
  Come utente registrato
  Voglio potermi creare un gruppo di mio interesse
  Per segnalare i miei interessi

  Contesto:
    Dato   che esistono i seguenti utenti:
      | name                  | email                 | password  | password_confirmation | nick | location   |  description |
      | Paperino              | paolino@nomail.it     | 12345678  | 12345678              | pap  | Paperopoli |  Papero      |


  Scenario:   Raggiungere la pagine di creazione gruppo
    Dato mi loggo con email "paolino@nomail.it" e password "12345678"
    E    mi trovo nella pagina di creazione gruppo
    Allora dovrei vedere il titolo "Creazione gruppo"


  Scenario:   Creazione gruppo (happy path)
    Dato mi loggo con email "paolino@nomail.it" e password "12345678"
    E      mi trovo nella pagina di creazione gruppo
    Quando inserisco in "group_name" "Un nome"
    E      inserisco in "group_description" "Una descrizione"
    Quando premo "Invia"
    Allora  dovrei essere nella pagina di dettagli del gruppo "Un nome"
    E dovrei vedere "Gruppo creato"
    E dovrei vedere "Paperino" all'interno di "span#group_owner"

  Scenario:  Non inserisco il nome
    Dato mi loggo con email "paolino@nomail.it" e password "12345678"
    E      mi trovo nella pagina di creazione gruppo
    Quando premo "Invia"
    E dovrei vedere il messaggio di errore "Name non può essere lasciato in bianco"


  Scenario:   Aggiungere gruppo (redirect amichevole)
    Dato     mi trovo nella pagina di creazione gruppo
    Allora dovrei essere nella pagina di login
    Quando mi loggo con email "paolino@nomail.it" e password "12345678"
    Allora dovrei essere nella pagina di creazione gruppo

  Scenario:   Aggiungere gruppo (nome duplicato)
    Dato mi loggo con email "paolino@nomail.it" e password "12345678"
    Dato     mi trovo nella pagina di creazione gruppo
    Quando inserisco in "group_name" "Un nome"
    Quando premo "Invia"
    Allora  dovrei essere nella pagina di dettagli del gruppo "Un nome"
    Dato     mi trovo nella pagina di creazione gruppo
    Quando inserisco in "group_name" "Un nome"
    Quando premo "Invia"
    Allora dovrei vedere il messaggio di errore "Name è già in uso"

