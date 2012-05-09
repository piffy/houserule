# language: it


Funzionalità: Mostra utente
  Come utente loggato
  Voglio poter vedere le informazioni degli utenti
  Per vedere se con chi potrei giocare

  Contesto:
    Dato   che esistono i seguenti utenti:
      | name                  | email                 | password  | password_confirmation |
      | Paperino              | paolino@nomail.it     | 12345678  | 12345678              |
      | Pluto                 | pluto@nomail.it       | 12345678  | 12345678              |
    E l'utente  "Paperino" ha fatto il login



  Scenario:   Visualizza propri dati

  Scenario:   Visualizza dati di altri utenti

  Scenario:   Visualizza dati senza essere loggato (Errore)

  Scenario:   Visualizza elenco partite cui l'utente partecipa


