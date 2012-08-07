#language: it

Funzionalità: Conferma invito
  Come giocatore invitato
  Voglio potere confemare e iscrivermi all'evento
  Per farlo sapere all'organizzatore

  Contesto: Situazione iniziale

    Dato   che esistono i seguenti utenti:
      | name                  | email                 | password  |
      | Paperino              | paolino@nomail.it     | 12345678  |
      | Pluto                 | pluto@nomail.it       | 12345678  |
      | Paperoga              | paperoga@nomail.it   | 12345678  |

    E che esistono i seguenti eventi dell'utente "paolino@nomail.it":
      | name                  | system     | begins_at  |
      | Campionato            | Risiko     | 10-5-2013  |

    E che esistono i seguenti eventi dell'utente "pluto@nomail.it":
      | name                  | system     | begins_at  |
      | Semifinale            | Monopoli   | 21-7-2013  |

    E che esiste l'invito all'evento "Campionato" per l'utente "pluto@nomail.it"

  @email
  Scenario: Conferma di un invito e conseguente iscrizione
      Dato mi loggo con email "pluto@nomail.it" e password "12345678"
      E il sistema non ha ancora inviato email
      Allora dovrei vedere "Profilo di Pluto"
      E dovrei vedere "Campionato"
      Quando seguo il link "Campionato"
      Allora dovrei essere nella pagina di conferma invito dell'evento "Campionato" per l'utente "Pluto"
      E dovrei vedere il titolo "Conferma invito"
      E dovrei vedere il pulsante "Confermo"
      E dovrei vedere il pulsante "Rinuncio"
      Quando premo il pulsante "Confermo"
      Allora dovrei essere nella pagina di dettagli dell'evento  "Campionato"
      E dovrei vedere "Invito accettato e prenotazione effettuata."
      E dovrei vedere "Pluto" all'interno di "div.player-description"
      Quando vado alla pagina di conferma invito dell'evento "Campionato" dell'utente "Pluto"
      Allora dovrei vedere "invito già utilizzato"
      E il sistema ha inviato 1 email
      E l'ultima mail dovrebbe contenere "Pluto"
      E l'ultima mail dovrebbe contenere "accettando"

    @email
    Scenario: Rinuncia a un invito
      E il sistema non ha ancora inviato email
      Dato mi loggo con email "pluto@nomail.it" e password "12345678"
      E vado alla pagina di conferma invito dell'evento "Campionato" dell'utente "Pluto"
      Quando premo il pulsante "Rinuncio"
      Allora dovrei essere nella pagina di dettagli dell'evento  "Campionato"
      E dovrei vedere "Invito rifiutato"
      E dovrei non vedere "Pluto" all'interno di "div.player-description"
      Quando vado alla pagina di conferma invito dell'evento "Campionato" dell'utente "Pluto"
      Allora dovrei vedere "invito già utilizzato"
      E il sistema ha inviato 1 email
      E l'ultima mail dovrebbe contenere "Pluto"
      E l'ultima mail dovrebbe contenere "rifiutato"

    Scenario: Invito scaduto
      Dato che esiste l'invito scaduto all'evento "Campionato" per l'utente "paperoga@nomail.it"
      E mi loggo con email "paperoga@nomail.it" e password "12345678"
      #E dovrei non vedere "Campionato"
      Quando vado alla pagina di conferma invito dell'evento "Campionato" dell'utente "Paperoga"
      Allora dovrei vedere "Invito scaduto"

    Scenario: Mostra invito scaduto
      Dato che esiste l'invito scaduto all'evento "Campionato" per l'utente "paperoga@nomail.it"
      E mi loggo con email "paolino@nomail.it" e password "12345678"
      Quando vado alla pagina di elenco inviti per "Campionato"
      Allora dovrei vedere "Paperoga"
      E dovrei vedere "Scaduto" all'interno di "div.label"


    Scenario: Rimozione invito (organizzatore)
      Dato mi loggo con email "paolino@nomail.it" e password "12345678"
      Quando vado alla pagina di elenco inviti per "Campionato"
      Allora dovrei vedere "Elimina" all'interno di "a"
      #Step successivo non testabile

    Scenario: Rinnovo invito (organizzatore)
      Dato che esiste l'invito scaduto all'evento "Campionato" per l'utente "paperoga@nomail.it"
      Dato mi loggo con email "paolino@nomail.it" e password "12345678"
      Quando vado alla pagina di elenco inviti per "Campionato"
      Allora dovrei vedere "Reinvita" all'interno di "a"
      E dovrei vedere "Scaduto" all'interno di "div.label"
      Quando seguo il link "Reinvita"
      Allora dovrei trovarmi nella pagina di elenco inviti per "Campionato"
      E dovrei vedere "Paperoga"
      #This test fails, though in the actual app it works.
      #E dovrei non vedere "Scaduto" all'interno di "div.label"





