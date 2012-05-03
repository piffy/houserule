# language: it


Funzionalità: Modifica utente
  Come utente loggato
  Voglio poter modificare le informazioni che mi interessano
  Per far sì che mostrino sempre dati aggiornati

Contesto:
  Dato   che esistono i seguenti utenti:
    | name                  | email                 | password  |
    | Paperino              | paolino@nomail.it     | 12345678  |
    | Pluto                 | pluto@nomail.it       | 12345678  |
  E l'utente  "Paperino" ha fatto il login


  Scenario:   Modifica nome

  Scenario:   Modifica nome con nome duplicato (Avvertimento)

  Scenario:   Modifica informazioni

  Scenario:   Modifica password

  Scenario:   Modifica password (Errore)

  Scenario:   Modifica nome

  Scenario:   Modifica dati altro utente (Errore)

  Scenario:   Modifica dati senza login (Errore)