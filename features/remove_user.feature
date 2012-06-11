# language: it

Funzionalità: Elimina utente
  Come utente
  voglio poter eliminare i miei dati
  perché non voglio più utilizzare il sistema


  Contesto:
    Dato  che esistono i seguenti utenti:
      | name                  | email                 | password  | password_confirmation |
      | Paperino              | paolino@nomail.it     | 12345678  | 12345678              |
      | Paperino              | pluto@nomail.it       | 12345678  | 12345678              |
    E      mi trovo nella pagina di login
    E      inserisco in "session_email" "paolino@nomail.it"
    E      inserisco in "session_password" "12345678"
    E      premo "Login"


  Scenario:   Eliminazione Utente (con navigazione)
    Dato  vado al profilo dell'utente "paolino@nomail.it"
    Quando seguo il link "Elimina utente"
    Allora dovrei vedere "Modifica di Paperino"
    E dovrei vedere "Disattivazione"
    Quando vado alla eliminazione dell'utente "paolino@nomail.it"
    Allora dovrei essere nella home page
    #Il prossimo passo NON può essere testato automaticamente


