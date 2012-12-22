#language: it
Funzionalità: mostrare la lista deglie eventi secondo vari criteri
  Come potenziale giocatore
  Voglio poter filtrare le partite presenti
  Per facilitare la ricerca


  Contesto:

    Dato   che esistono i seguenti utenti:
      | name                  | email                 | password  |
      | Paperino              | paolino@nomail.it     | 12345678  |
      | Pluto                 | pluto@nomail.it       | 12345678  |



  Scenario: filtra gli eventi passati
    E ci sono 3 eventi di "paolino@nomail.it"
    E ci sono 2 eventi passati di "pluto@nomail.it"
    Dato mi trovo nella pagina di elenco eventi
    Quando scelgo "selection_not_begun"
    E premo "Aggiorna"
    Allora dovrei non vedere "Past Event"
    E dovrei vedere "3" all'interno di "span#event_selected_count"
    Quando scelgo "selection_all_events"
    E premo "Aggiorna"
    Allora dovrei vedere "Past Event"
    E dovrei vedere "5" all'interno di "span#event_selected_count"

Scenario: filtra gli eventi indefiniti
    E ci sono 3 eventi di "paolino@nomail.it"
    E ci sono 2 eventi indefiniti di "pluto@nomail.it"
    Dato mi trovo nella pagina di elenco eventi
    Quando scelgo "selection_no_date"
    E premo "Aggiorna"
    Allora dovrei vedere "Indefinite Event"
    E dovrei vedere "Indefinito" all'interno di "span.btn"
    E dovrei vedere "2" all'interno di "span#event_selected_count"
    Quando scelgo "selection_all_events"
    E premo "Aggiorna"
    Allora dovrei non vedere "Indefinte"
    E dovrei vedere "5" all'interno di "span#event_selected_count"


Scenario: Di default mostra solo gli eventi non iniziati
    E ci sono 3 eventi di "paolino@nomail.it"
    E ci sono 2 eventi passati di "pluto@nomail.it"
    Dato mi trovo nella pagina di elenco eventi
    Allora dovrei non vedere "Past Event"
    E dovrei vedere "3" all'interno di "span#event_selected_count"


