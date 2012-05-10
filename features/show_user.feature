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
    Dato che visito la pagina di visualizzazione utente di "paolino@nomail.it"
    Allora    dovrei vedere "Paperino" nel campo "name"
    E         dovrei vedere "paolino@nomail.it" nel campo "email"
    E         dovrei vedere "pap" nel campo "nick"
    E         dovrei vedere  "Un gran papero" nel campo "description"
    E         dovrei vedere  "Paperopoli" nel campo "Location"
    E         dovrei vedere  "Iscritto il"



  Scenario:   Non visualizza email di altri utenti (se non sei admin)
  Dato che visito la pagina di visualizzazione utente di "pluto@nomail.it"
    Allora    dovrei vedere "Pluto" nel campo "name"
    E         dovrei non vedere "pluto@nomail.it" nel campo "email"


