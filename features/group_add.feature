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
    Dato   mi trovo nella pagina di login
    E      inserisco in "session_email" "paolino@nomail.it"
    E      inserisco in "session_password" "12345678"
    E      premo "Login"
    E      mi trovo nella pagina di creazione gruppo
    #Allora dovrei vedere il titolo "Creazione gruppo"


  Scenario:   Creazione gruppo
    Dato   mi trovo nella pagina di login
    E      inserisco in "session_email" "paolino@nomail.it"
    E      inserisco in "session_password" "12345678"
    E      premo "Login"
    E      mi trovo nella pagina di creazione gruppo
    Quando inserisco in "group_name" "Un nome"
    E      inserisco in "group_description" "Una descrizione"
    E      inserisco in "group_user_id" "1"
    Quando premo "Invia"
    Allora  dovrei essere nella pagina di dettagli del gruppo "Un nome"
    E dovrei vedere "Gruppo creato"

  Scenario:   Aggiungere gruppo (redirect amichevole)
    Dato     mi trovo nella pagina di creazione gruppo
    Allora dovrei essere nella pagina di login
    Quando inserisco in "session_email" "paolino@nomail.it"
    E      inserisco in "session_password" "12345678"
    Quando premo "Login"
    Allora dovrei essere nella pagina di creazione gruppo

  Scenario:   Aggiungere gruppo (nome duplicato)

