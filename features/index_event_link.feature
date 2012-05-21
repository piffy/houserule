#language: it
Funzionalità: Usare i link delle'elenco eventi

  Come potenziale giocatore
  Voglio poter andare alla pagina di prenotazione o di modifica eventi
  Per operare le mie scelte.


  Contesto: esitono già diverse partite

    Dato   che esistono i seguenti utenti:
      | name                  | email                 | password  | password_confirmation | nick | location   |  description |
      | Paperino              | paolino@nomail.it     | 12345678  | 12345678              | pap  | Paperopoli |  Papero      |
      | Pluto                 | pluto@nomail.it       | 12345678  | 12345678              |      | Topolinia  |  Cane        |
    E che esistono i seguenti eventi dell'utente "paolino@nomail.it":
      | name                  | system     | begins_at  | deadline   |  status |
      | Campionato            | Risiko     | 10-5-2013  | 10-5-2013  |  1      |
      | Torneo                | Monopoli   | 11-5-2013  | 11-5-2013  |  1      |
      | Campagna              | D&D        | 12-5-2013  | 12-5-2013  |  1      |
      | LAN Party             | Diablo3    | 13-5-2013  | 13-5-2013  |  1      |
      | Concorso              | Pandemics  | 14-5-2013  | 14-5-2013  |  1      |
      | Semifinale Torneo     | Scacchi    | 15-5-2013  | 15-5-2013  |  1      |



  Scenario: Dettagli evento
    Dato mi trovo nella pagina di elenco eventi
    Quando seguo il link "Campionato"
    * mostra la pagina
    Allora  dovrei essere nella pagina dettagli dell'evento  "Campionato"



  Scenario: Modifica evento (non loggato)
    Dato mi trovo nella pagina di elenco eventi
    Quando premo "Edit"
    Allora  mi trovo alla pagina di login

  Scenario: Modifica evento (loggato)
    Dato   mi trovo nella pagina di login
    E      inserisco in "session_email" "paolino@nomail.it"
    E      inserisco in "session_password" "12345678"
    E      premo "Login"
    E      mi trovo nella pagina di elenco eventi
    Quando premo "Edit"
    Allora  mi trovo alla pagina di dettaglio evento per l'evento "Campionato"


