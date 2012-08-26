# language: it

Funzionalità:  Utente amministratore
  Come utente amministratore
  voglio poter accedere e modificare i dati di tutti
  per poter gestire i problemi generali del sito

  Contesto: Utente amministratore esistente e loggato
    Dato esiste l'utente amministratore "admin@houserule.it"
    E mi loggo con email "admin@houserule.it" e password "foobar"


  Scenario:   Visualizzazione
    Quando mi trovo nella homepage
    Allora dovrei vedere "*" all'interno di "span.badge"
    E dovrei vedere "Amministrazione" all'interno di "li"
    Quando vado al profilo dell'utente "admin@houserule.it"
    Allora dovrei vedere "Amministratore"



  Scenario: Accesso a tutti gli utenti
    Dato ci sono 3 utenti
    Quando vado alla modifica preferenze di un utente
    Allora dovrei non vedere "Azione non consentita"
    E dovrei vedere il titolo "Preferenze"

  Scenario: Accesso a tutti gli eventi, inviti ,annunci, messaggi
    Dato   che esistono i seguenti utenti:
      | name                  | email                 | password  |
      | Paperino              | paolino@nomail.it     | 12345678  |
    E ci sono 3 eventi di "paolino@nomail.it"
    Quando mi trovo nella pagina di elenco eventi
    Allora dovrei vedere "Modifica" all'interno di "a.btn"
    Quando vado alla modifica di un evento
    Allora dovrei non vedere "Azione non consentita"
    E dovrei vedere il titolo "Modifica"
    Quando vado ai dettagli di un evento
    Allora dovrei vedere "Messaggi" all'interno di "a.btn"
    E dovrei vedere "Annuncia" all'interno di "a.btn"
    E dovrei vedere "Inviti" all'interno di "a.btn"
    Quando seguo il link "Inviti"
    Allora dovrei non vedere "Azione non consentita"
    Quando vado ai dettagli di un evento
    E seguo il link "Annuncia"
    Allora dovrei non vedere "Azione non consentita"
    Quando vado ai dettagli di un evento
    E seguo il link "Messaggi"
    Allora dovrei non vedere "Azione non consentita"


  Scenario: Accesso a tutti i gruppi e relativo interesse
    Dato   che esistono i seguenti utenti:
      | name                  | email                 | password  |
      | Paperino              | paolino@nomail.it     | 12345678  |
      | Pippo                 | pippo@nomail.it       | 12345678  |
    E che esistono i seguenti gruppi di "paolino@nomail.it":
      | name                  | description               |
      | Gruppo 1              | Un grande gruppo          |
    E a "Pippo" interessa il gruppo "Gruppo 1"
    Dato    vado alla modifica gruppo di "Gruppo 1"
    Allora  dovrei non vedere "Azione non consentita"
    Quando vado alla modifica interesse di "Gruppo 1" per "Pippo"
    Allora  dovrei non vedere "Azione non consentita"



  Scenario: Invio messaggi a tutti gli utenti
    Dato ci sono 5 utenti
    Quando vado alla pagina di amministrazione
    Allora dovrei non vedere "Azione non consentita"
    E dovrei vedere il titolo "Amministrazione"
    Quando seguo il link "Wall"
    Allora dovrei vedere il titolo "Wall"
    Quando inserisco in "welcome_subject" "Un soggetto interessante"
    E inserisco in "welcome_body" "Un testo sorprendente"
    E premo il pulsante "Invia messaggio"
    Allora dovrei essere nella home page
    E dovrei vedere "5 messaggi inviati"

  Scenario: Invio messaggi senza oggetto o senza testo (sad path)
    Quando vado alla pagina di amministrazione
    E seguo il link "Wall"
    Allora dovrei vedere il titolo "Wall"
    Quando inserisco in "welcome_subject" "Un soggetto interessante"
    E premo il pulsante "Invia messaggio"
    Allora dovrei vedere il titolo "Wall"
    Quando inserisco in "welcome_body" "Un testo sorprendente"
    E premo il pulsante "Invia messaggio"
    Allora dovrei vedere il titolo "Wall"



