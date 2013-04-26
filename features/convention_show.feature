#language: it
Funzionalità: Visualizzare i dati di una convention
  Come giocatore
  Voglio poter vedere i dati e l'elenco degli eventi della convention
  Per iscrivermi a qualche evento


  Contesto:
    Dato   che esistono i seguenti utenti:
      | name                  | email                 | password  | password_confirmation | nick | location   |  description |
      | Paperino              | paolino@nomail.it     | 12345678  | 12345678              | pap  | Paperopoli |  Papero      |

    E che ci sono 1 conventions di "paolino@nomail.it"


  Scenario: Mostra i dati principali (non loggato)
    Dato    vado alla pagina di visualizzazione di una convention
    Allora dovrei vedere il titolo "Dettagli convention"
    E dovrei vedere "Paperino" all'interno di "a#convention_owner"
    E dovrei vedere "Convention 1" all'interno di "h1"
    E dovrei non vedere "Modifica" all'interno di "a.btn"

  Scenario: Mostra i dati principali (loggato come organizzatore)
    Dato   mi loggo con email "paolino@nomail.it" e password "12345678"
    E    vado alla pagina di visualizzazione di una convention
    Allora dovrei vedere il titolo "Dettagli convention"
    E dovrei vedere "Modifica" all'interno di "a.btn"
