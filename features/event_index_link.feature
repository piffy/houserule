#language: it
Funzionalità: Usare i link dell'elenco eventi

  Come potenziale giocatore
  Voglio poter andare alla pagina di prenotazione o di modifica eventi
  Per operare le mie scelte.


  Contesto: esitono già diverse partite

    Dato   che esistono i seguenti utenti:
      | name                  | email                 | password  | password_confirmation | nick | location   |  description |
      | Paperino              | paolino@nomail.it     | 12345678  | 12345678              | pap  | Paperopoli |  Papero      |
      | Pluto                 | pluto@nomail.it       | 12345678  | 12345678              |      | Topolinia  |  Cane        |

    E che esistono i seguenti eventi dell'utente "paolino@nomail.it":
      | name                  | system     | begins_at  |
      | Campionato            | Risiko     | 10-5-2014  |

    Dato ci sono 3 eventi di "paolino@nomail.it"


  Scenario: Dettagli evento
    Dato mi trovo nella pagina di elenco eventi
    Quando seguo il link "Campionato"
    Allora  dovrei essere nella pagina di dettagli dell'evento  "Campionato"

  Scenario: Modifica evento (non loggato)
    Dato mi trovo nella pagina di elenco eventi
    Allora dovrei non vedere "Modifica"


  Scenario: Modifica evento (loggato)
    Dato mi loggo con email "paolino@nomail.it" e password "12345678"
    E mi trovo nella pagina di elenco eventi
    E seguo il link "Nome evento"
    E seguo il link "Modifica"
    Allora  dovrei essere nella pagina di modifica dell'evento  "Campionato"

  Scenario: Mostra gli ultimi 5 eventi impostati nella hp
    Dato ci sono 1 eventi di "pluto@nomail.it"
    E che esistono i seguenti eventi dell'utente "paolino@nomail.it":
      | name                  | system     | begins_at  |
      | Last event            | Strange     | 9-5-2013  |
    E mi trovo nella homepage
    Allora dovrei non vedere "Event 14"
    E dovrei non vedere "Campionato"
    E dovrei vedere "Last event" all'interno di "a"
    E dovrei vedere "6 eventi presenti"

  Scenario: Non mostra gli eventi passati nella hp
    Dato ci sono 2 eventi passati di "pluto@nomail.it"
    E mi trovo nella homepage
    Allora dovrei non vedere "Past Event"
    E dovrei vedere "6 eventi presenti"
