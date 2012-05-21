#language: it
Funzionalità: mostrare la lista deglie eventi secondo vari criteri

  Come potenziale giocatore
  Voglio poter vedere le partite ordinato per nome, data e sistema
  Per facilitare la mia ricerca


  Contesto: esitono già diverse partite

    Dato   che esistono i seguenti utenti:
      | name                  | email                 | password  | password_confirmation | nick | location   |  description |
      | Paperino              | paolino@nomail.it     | 12345678  | 12345678              | pap  | Paperopoli |  Papero      |
      | Pluto                 | pluto@nomail.it       | 12345678  | 12345678              |      | Topolinia  |  Cane        |
    E che esistono i seguenti eventi dell'utente "paolino@nomail.it":
      | name                  | system     | begins_at  |
      | Campionato            | Risiko     | 10-5-2013  |
      | Torneo                | Monopoli   | 11-5-2013  |
      | Campagna              | D&D        | 12-5-2013  |
      | LAN Party             | Diablo3    | 13-5-2013  |
      | Concorso              | Pandemics  | 14-5-2013  |
      | Semifinale Torneo     | Scacchi    | 15-5-2013  |




  Scenario: ordina gli eventi in ordine di data (default)
    Dato mi trovo nella pagina di elenco eventi
    Allora dovrei vedere "Torneo" prima di  "Campionato"
    E dovrei vedere "Concorso" prima di  "LAN Party"
    E dovrei vedere "Semifinale Torneo" prima di  "Torneo"

  Scenario: ordina gli eventi in ordine alfabetico
    Dato mi trovo nell'elenco eventi con ordinamento "name"
    Allora dovrei vedere "Campionato" prima di  "Concorso"
    E dovrei vedere "Concorso" prima di  "LAN Party"
    E dovrei vedere "Semifinale Torneo" prima di  "Torneo"

  Scenario: ordina gli eventi in ordine di data decrescente
    Dato mi trovo nell'elenco eventi con ordinamento "begins_at"
    * mostra la pagina
    Allora dovrei vedere "Torneo" prima di  "Campionato"
    E dovrei vedere "Concorso" prima di  "LAN Party"
    E dovrei vedere "Semifinale Torneo" prima di  "Torneo"

  Scenario: ordina gli eventi per sistema di gioco

    Dato mi trovo nell'elenco eventi con ordinamento "system"
    * mostra la pagina
    Allora dovrei vedere "Torneo" prima di  "Campionato"
    E dovrei vedere "Campagna" prima di  "LAN Party"
    E dovrei vedere "Torneo" prima di  "Concorso"


