# language: it

Funzionalità:
  Come utente
  voglio poter consultare la lista degli eventi e trarne informazioni
  perché

  Contesto:

    Dato   che esistono i seguenti utenti:
      | name                  | email                 | password  |
      | Paperino              | paolino@nomail.it     | 12345678  |
      | Pluto                 | pluto@nomail.it       | 12345678  |
      | Qui                   | qui@nomail.it         | 12345678  |
      | Quo                   | quo@nomail.it         | 12345678  |

  Scenario: Paginazione
    E ci sono 40 eventi di "paolino@nomail.it"
    Dato mi trovo nella pagina di elenco eventi
    Allora dovrei non vedere "Event 31"
    E dovrei vedere "Event 30"


  Scenario: Mostra barra di progresso rossa se evento al completo
    E che esistono i seguenti eventi dell'utente "pluto@nomail.it":
      | name                  | system     | begins_at  | deadline   | max_player_num | min_player_num |
      | Semifinale            | Monopoli   | 21-7-2013  | 21-7-2013  |       1        |        1       |
    Dato che esiste la prenotazione dell'evento "Semifinale" per l'utente "paolino@nomail.it"
    Dato mi trovo nella pagina di elenco eventi
    Allora dovrei vedere "" all'interno di "div.bar-danger"

  Scenario: Mostra barra di progresso rossa se evento al di sotto del minimo
    E che esistono i seguenti eventi dell'utente "pluto@nomail.it":
      | name                  | system     | begins_at  | deadline   | max_player_num | min_player_num |
      | Semifinale            | Monopoli   | 21-7-2013  | 21-7-2013  |       4        |        2       |
    Dato che esiste la prenotazione dell'evento "Semifinale" per l'utente "paolino@nomail.it"
    Dato mi trovo nella pagina di elenco eventi
    Allora dovrei vedere "" all'interno di "div.bar-danger"

  Scenario: Mostra barra di progresso verde se tutto OK
    E che esistono i seguenti eventi dell'utente "pluto@nomail.it":
      | name                  | system     | begins_at  | deadline   | max_player_num | min_player_num |
      | Semifinale            | Monopoli   | 21-7-2013  | 21-7-2013  |       4        |        1       |
    Dato che esiste la prenotazione dell'evento "Semifinale" per l'utente "paolino@nomail.it"
    Dato mi trovo nella pagina di elenco eventi
    Allora dovrei vedere "" all'interno di "div.bar-success"

  Scenario: Mostra barra di progresso arancione se evento è quasi completo
    Dato che esistono i seguenti eventi dell'utente "pluto@nomail.it":
      | name                  | system     | begins_at  | deadline   | max_player_num | min_player_num |
      | Semifinale            | Monopoli   | 21-7-2013  | 21-7-2013  |       5        |        1       |
    Dato che esiste la prenotazione dell'evento "Semifinale" per l'utente "paolino@nomail.it"
    E che esiste la prenotazione dell'evento "Semifinale" per l'utente "pluto@nomail.it"
    E che esiste la prenotazione dell'evento "Semifinale" per l'utente "qui@nomail.it"
    E che esiste la prenotazione dell'evento "Semifinale" per l'utente "quo@nomail.it"
    Quando mi trovo nella pagina di elenco eventi
    Allora dovrei vedere "" all'interno di "div.bar-warning"

  Scenario: Mostra icona nel caso di eventi con solo invito

    Dato che esistono i seguenti eventi dell'utente "pluto@nomail.it":
      | name                  | system     | begins_at  | deadline   | invite_only |
      | Riservato             | Strano     | 21-7-2013  | 21-7-2013  |      true   |
    Quando mi trovo nella pagina di elenco eventi
    Allora dovrei vedere "" all'interno di "i.icon-exclamation-sign"
    E dovrei non vedere "Prenota" all'interno di "a"

  Scenario: Non mostrare bottone in caso di evento bloccato
    Dato che esistono i seguenti eventi dell'utente "pluto@nomail.it":
      | name                  | system     | begins_at  | deadline   | reservation_locked |
      | Bloccato              | Strano     | 21-7-2013  | 21-7-2013  |      true          |
    Quando mi trovo nella pagina di elenco eventi
    Allora dovrei non vedere "Prenota" all'interno di "a"

  Scenario: Evento al completo
    Dato che esistono i seguenti eventi dell'utente "pluto@nomail.it":
      | name                  | system     | begins_at  | deadline   | max_player_num | min_player_num |
      | Soltero               | Monopoli   | 21-7-2013  | 21-7-2013  |       1        |        1       |
    E che esiste la prenotazione dell'evento "Soltero" per l'utente "paolino@nomail.it"
    Quando mi trovo nella pagina di elenco eventi
    Allora dovrei non vedere "Prenota" all'interno di "a"
    E dovrei vedere "Pieno" all'interno di "span"
