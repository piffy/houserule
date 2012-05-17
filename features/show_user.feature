# language: it


Funzionalità: Mostra utente
  Come utente loggato
  Voglio poter vedere le informazioni degli utenti
  Per vedere se con chi potrei giocare

  Contesto:
    Dato   che esistono i seguenti utenti:
      | name                  | email                 | password  | password_confirmation | nick | location   |  description |
      | Paperino              | paolino@nomail.it     | 12345678  | 12345678              | pap  | Paperopoli |  Papero      |
      | Pluto                 | pluto@nomail.it       | 12345678  | 12345678              |      | Topolinia  |  Cane        |
    E mi loggo con email "paolino@nomail.it" e password "12345678"


  Scenario:   Visualizza propri dati
    Dato      vado al profilo dell'utente "paolino@nomail.it"
    Allora    dovrei vedere "Paperino" all'interno di "li"
    E         dovrei vedere "Bentornato pap!" all'interno di "h1"
    E         dovrei vedere "pap" all'interno di "li"
    E         dovrei vedere "Paperopoli" all'interno di "li"
    E         dovrei vedere "Papero" all'interno di "p#description"
    E         dovrei vedere "Eventi organizzati: 0"
    E         dovrei vedere "Organizza evento"


  Scenario:   Visualizza partite organizzate
    Dato che esistono i seguenti eventi dell'utente "paolino@nomail.it":
      | name                  | system     |
      | Evento 1              | Risiko     |
      | Evento 2              | Monopoli   |
    Dato  vado al profilo dell'utente "paolino@nomail.it"
    Allora dovrei vedere "Eventi organizzati" all'interno di "h3#organized-events"
    E dovrei vedere "2" all'interno di "h3#organized-events"
    E dovrei vedere "Evento 1" all'interno di "span"
    E dovrei vedere "Evento 2" all'interno di "span"


  Scenario:   Visualizza dati di altri utenti
    Dato      vado al profilo dell'utente "pluto@nomail.it"
    Allora    dovrei vedere "Pluto" all'interno di "li"
    E         dovrei vedere "Bentornato Pluto!" all'interno di "h1"
    E         dovrei vedere "Topolinia" all'interno di "li"
    E         dovrei vedere "Cane" all'interno di "p#description"
    E         dovrei non vedere "Organizza evento"




