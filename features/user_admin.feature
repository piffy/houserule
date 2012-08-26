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
    Quando vado al profilo dell'utente "admin@houserule.it"
    Allora dovrei vedere "Amministratore"


  Scenario: Accesso a tutti gli utenti
    Dato ci sono 3 utenti
    Quando vado alla modifica preferenze di un utente
    Allora dovrei non vedere "Azione non consentita"
    E dovrei vedere il titolo "Preferenze"

  Scenario: Accesso a tutti gli eventi

  Scenario: Pagina speciale amministrativa

  Scenario: Invio messaggi a tutti gli utenti


