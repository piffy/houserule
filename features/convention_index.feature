#language: it
Funzionalità: Visualizzare le convention presenti
  Come giocatore
  Voglio poter consultare l'elenco delle convention esistenti
  Per consultare e stampare il programma.

Contesto:
  Dato   che esistono i seguenti utenti:
    | name                  | email                 | password  | password_confirmation | nick | location   |  description |
    | Paperino              | paolino@nomail.it     | 12345678  | 12345678              | pap  | Paperopoli |  Papero      |


Scenario: Visualizzazione a lista (con navigazione)
  E che ci sono 6 conventions di "paolino@nomail.it"
  E mi trovo nella home page
  Quando seguo il link "Convention"
  Allora dovrei vedere il titolo "Calendario Convention"

  Allora dovrei vedere "Convention" all'interno di ".convention_info"
  Allora dovrei vedere "Organizzato da:" all'interno di ".convention_info"
  E      dovrei vedere "" all'interno di ".convention_info"
  E      dovrei vedere "" all'interno di ".icon48"

Scenario: Visualizzazione ordinata per data
  Dato   che esistono le seguenti convention:
    | name                  | location              | begin_date  | end_date   |
    | First                 | A place               | 12-04-2016  | 12-04-2016 |
    | Before                | A better place        | 11-04-2016  | 11-04-2016 |
    | Christmas             | Home                  | 25-12-2015  | 25-12-2015 |
  Quando vado alla pagina di elenco convention
  Allora dovrei vedere "Christmas" prima di  "Before"
  E dovrei vedere "Before" prima di  "First"



Scenario: Convention attiva segnalata
  Dato che esiste una convention
  E che la convention si svolge oggi
  Quando vado alla pagina di elenco convention
  Allora dovrei vedere "Convention" all'interno di ".info"


Scenario: Convention passata non mostrata
  Dato che esiste una convention
  E che la convention si svolgeva ieri
  Quando vado alla pagina di elenco convention
  Allora dovrei non vedere "Convention" all'interno di "td"

Scenario: Elenco convention passate
  Dato che esiste una convention
  E che la convention si svolgeva ieri
  Quando vado alla pagina di elenco convention
  E scelgo "selectionc_past"
  E premo "Aggiorna"
  Allora dovrei vedere "Convention" all'interno di "td"






