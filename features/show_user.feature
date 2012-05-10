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


  Scenario:   Visualizza dati di altri utenti
    Dato      vado al profilo dell'utente "pluto@nomail.it"
    E         mostra la pagina
    Allora    dovrei vedere "Pluto" all'interno di "li"
    E         dovrei vedere "Bentornato Pluto!" all'interno di "h1"
    E         dovrei vedere "Topolinia" all'interno di "li"
    E         dovrei vedere "Cane" all'interno di "p#description"





