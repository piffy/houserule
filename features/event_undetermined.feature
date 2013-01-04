# language: it

Funzionalità:
  Come organizzatore di eventi
  voglio poter avere eventi con data non stabilita
  per poter stabilire se interessa.

  Contesto: Esiste un evento non definito
    Dato   che esistono i seguenti utenti:
      | name                  | email                 | password  |
      | Paperino              | paolino@nomail.it     | 12345678  |
      | Pippo                 | pippo@nomail.it       | 12345678  |



    Scenario: Filtra eventi indefiniti
    E ci sono 4 eventi indefiniti di "paolino@nomail.it"
    E mi trovo nella pagina di elenco eventi
    E dovrei vedere "0" all'interno di "span#event_selected_count"
    E dovrei vedere "4" all'interno di "span#event_total_count"
    Quando scelgo "selection_no_date"
    E premo "Aggiorna"
    E dovrei vedere "4" all'interno di "span#event_selected_count"
    E dovrei vedere "4" all'interno di "span#event_total_count"


    Scenario: Mostra eventi indefiniti nella home page
    Dato ci sono 7 eventi indefiniti di "paolino@nomail.it"
    Dato che mi trovo nella home page
    Allora dovrei vedere "Eventi in cantiere"
    E dovrei vedere "Indefinite Event"
    E dovrei vedere "...ed altri 2"

  Scenario:   Impossibile prenotare
    Dato ci sono 1 eventi indefiniti di "paolino@nomail.it"
    E mi loggo con email "paolino@nomail.it" e password "12345678"
    Quando vado ai dettagli di un evento
    E seguo il link "Prenota"
    Allora dovrei vedere il titolo "Dettagli evento"
    E dovrei vedere "Prenotazione impossibile: data non stabilita"

  Scenario:   Impossibile invitare
    Dato ci sono 1 eventi indefiniti di "paolino@nomail.it"
    E mi loggo con email "paolino@nomail.it" e password "12345678"
    Quando vado ai dettagli di un evento
    E seguo il link "Inviti"
    E seguo il link "Invita"
    Allora dovrei vedere il titolo "Dettagli evento"
    E dovrei vedere "Invito impossibile: data non stabilita"

  @email
  Scenario: Invio mail di annuncio possibile ma con avvertimento
    Dato ci sono 1 eventi indefiniti di "paolino@nomail.it"
    E il sistema non ha ancora inviato emails
    E mi loggo con email "paolino@nomail.it" e password "12345678"
    Quando vado ai dettagli di un evento
    E seguo il link "Annuncia"
    Quando inserisco "topolino@nomail.com" nel campo email "0"
    E inserisco "paperoga@nomail.com" nel campo email "1"
    Quando premo "Invia annuncio a questi indirizzi"
    Allora dovrei vedere "Annuncio inviato a 2 indirizzi"
    E l'ultima mail dovrebbe contenere "Non ancora stabilita"
    E il sistema ha inviato 1 emails

  @email
  Scenario:   Cambiamento da standard a senza data (rimozione inviti e prenotazioni)
    Dato che esistono i seguenti eventi dell'utente "paolino@nomail.it":
      | name                  | system     | begins_at  |  deadline |
      | Campionato            | Risiko     | 10-5-2013  | 9-5-2013  |
    E che esiste l'invito all'evento "Campionato" per l'utente "pippo@nomail.it"
    E che esiste la prenotazione dell'evento "Campionato" per l'utente "paolino@nomail.it"
    Dato   mi loggo con email "paolino@nomail.it" e password "12345678"
    E      vado alla modifica evento di "Campionato"
    E      premo "Prossimo"
    E      premo "Prossimo"
    Quando scelgo "no_date"
    E premo "Prossimo"
    E premo "Termina"
    Allora dovrei essere nella pagina di dettagli dell'evento  "Campionato"
    E dovrei non vedere "Deadline"
    E dovrei vedere "Indefinito" all'interno di "span.label-info"
    E dovrei vedere "Non ancora stabilita" all'interno di "p"
    E dovrei vedere "(0)" all'interno di "span#invitation_count"
    E dovrei vedere "Prenotati ( 0 )"
    E il sistema ha inviato 1 emails
    E l'ultima mail dovrebbe contenere "evento in questione ha modificato la data"


