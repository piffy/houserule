#language: it
Funzionalità: mostrare la lista deglie eventi secondo vari criteri
  Come potenziale giocatore
  Voglio poter filtrare le partite presenti
  Per facilitare la ricerca


  Contesto:

    Dato   che esistono i seguenti utenti:
      | name                  | email                 | password  | password_confirmation | nick | location   |  description |
      | Paperino              | paolino@nomail.it     | 12345678  | 12345678              | pap  | Paperopoli |  Papero      |
      | Pluto                 | pluto@nomail.it       | 12345678  | 12345678              |      | Topolinia  |  Cane        |

    E ci sono 3 eventi di "paolino@nomail.it"
    E ci sono 2 eventi passati di "pluto@nomail.it"


  Scenario: filtra gli eventi passati
    Dato mi trovo nella pagina di elenco eventi
    Allora dovrei vedere "Past Event"
    Quando scelgo "selection_not_begun"
    E premo "Aggiorna"
    Allora dovrei non vedere "Past Event"
    Quando scelgo "selection_all_events"
    E premo "Aggiorna"
    Allora dovrei vedere "Past Event"



