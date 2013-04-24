# language: it
Funzionalità: Modifica convention
  Come gestore di una convention
  Voglio poter modificarla o cancellarla
  Per tenere aggiornata la situazione

  Contesto:
    Dato   che esistono i seguenti utenti:
      | name                  | email                 | password  | password_confirmation | nick | location   |  description |
      | Paperino              | paolino@nomail.it     | 12345678  | 12345678              | pap  | Paperopoli |  Papero      |
      | Pippo                 | pippo@nomail.it       | 12345678  | 12345678              | pap  | Paperopoli |  Papero      |

    E che ci sono 1 conventions di "paolino@nomail.it"


  Scenario:   Navigazione e Modifica
    Dato mi loggo con email "paolino@nomail.it" e password "12345678"
    E    vado alla modifica convention
    Allora dovrei vedere il titolo "Modifica convention"
    Quando inserisco in "convention_name" "Una Convention modificata"
    E      inserisco in "convention_begin_date_only" "21-12-2013"
    E      inserisco in "convention_end_date_only" "23-12-2013"
    E      inserisco in "convention_location" "My place"
    Quando premo "Invia"
    Allora  dovrei essere nella pagina di dettagli di una convention
    E dovrei vedere "Convention modificata"
    Quando      vado alla pagina di elenco convention
    Allora dovrei vedere "Una Convention modificata"
    #E      dovrei vedere "" all'interno di "i.icon-calendar"

  Scenario:   Altro utente
    Dato   mi loggo con email "pippo@nomail.it" e password "12345678"
    Dato    vado alla modifica convention
    Allora  dovrei vedere "Azione non consentita"


  Scenario:   Eliminazione Convention (con navigazione)
    Dato mi loggo con email "paolino@nomail.it" e password "12345678"
    E      vado alla modifica convention
    Quando inserisco in "convention_name" "Erasable"
    E      dovrei vedere il pulsante "Elimina"
    Quando premo "Invia"
    Quando vado alla eliminazione della convention "Erasable"
    E      vado alla pagina di elenco convention
    Allora dovrei non vedere "Convention 1"

