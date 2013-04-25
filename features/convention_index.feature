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
  * mostra la pagina
  Allora dovrei vedere il titolo "Calendario Convention"

  Allora dovrei vedere "Convention" all'interno di ".convention_info"
  Allora dovrei vedere "Organizzato da:" all'interno di ".convention_info"
  E      dovrei vedere "" all'interno di ".convention_info"
  E      dovrei vedere "" all'interno di ".icon64"

Scenario: Visualizzazione a calendario





