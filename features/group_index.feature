#language: it
Funzionalità: Visualizzare i gruppi presenti
  Come giocatore
  Voglio poter consultare l'elenco dei gruppi esistenti
  Per iscrivermi eventualmente.


  Contesto:
    Dato   che esistono i seguenti utenti:
      | name                  | email                 | password  | password_confirmation | nick | location   |  description |
      | Paperino              | paolino@nomail.it     | 12345678  | 12345678              | pap  | Paperopoli |  Papero      |
      | Pluto                 | pluto@nomail.it       | 12345678  | 12345678              |      | Topolinia  |  Cane        |

  Scenario: Visualizzazione base
    Dato che ci sono 6 gruppi di "paolino@nomail.it"
    E vado alla pagina di elenco gruppo
    Allora dovrei vedere il titolo "Gruppi"
    Allora dovrei vedere "Nome" all'interno di "th"
    E      dovrei vedere "Descrizione" all'interno di "th"
    E      dovrei vedere "Luogo" all'interno di "th"
    E      dovrei vedere "Creato da" all'interno di "th"
    E      dovrei vedere "Iscritti" all'interno di "th"


  Scenario: Paginazione
    Dato che ci sono 31 gruppi di "paolino@nomail.it"
    E vado alla pagina di elenco gruppo
    Allora dovrei vedere "Group 7"
    E dovrei non vedere "Group 37"


