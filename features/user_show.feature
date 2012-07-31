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
    Allora    dovrei vedere "Paperino" all'interno di "h1"
    E         dovrei vedere "pap" all'interno di "h1"
    E         dovrei vedere "Paperopoli" all'interno di "p"
    E         dovrei vedere "Papero" all'interno di "p"


  Scenario:   Visualizza partite organizzate
    Dato che esistono i seguenti eventi dell'utente "paolino@nomail.it":
      | name                  | system     |  begins_at |
      | Evento 1              | Risiko     |  10-5-2013 |
      | Evento 2              | Monopoli   |  13-5-2013 |
    Dato  vado al profilo dell'utente "paolino@nomail.it"
    Allora dovrei vedere "2" all'interno di "p"
    E dovrei vedere "Evento 1" all'interno di "li"
    E dovrei vedere "Evento 2" all'interno di "li"


  Scenario:   Visualizza le prenotazioni
    Dato che esistono i seguenti eventi dell'utente "paolino@nomail.it":
      | name                  | system     |  begins_at |
      | Evento 1              | Risiko     |  10-5-2013 |
      | Evento 2              | Monopoli   |  13-5-2013 |
    E che esiste la prenotazione dell'evento "Evento 1" per l'utente "paolino@nomail.it"
    Quando  vado al profilo dell'utente "paolino@nomail.it"
    Allora dovrei vedere "2" all'interno di "p"
    E dovrei vedere "Evento 1" all'interno di "li"


  Scenario:   Visualizza dati di altri utenti
    Dato      vado al profilo dell'utente "pluto@nomail.it"
    Allora    dovrei vedere "Pluto" all'interno di "h1"
    E         dovrei vedere "Topolinia" all'interno di "p"
    E         dovrei vedere "Cane" all'interno di "p"
    E         dovrei non vedere "Organizza evento" all'interno di "a#button"




