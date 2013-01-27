# language: it

Funzionalità:
  Come visitatore
  voglio vedere gli utenti collegati
  perché mi interessa sapere quanto sono attivi

  Contesto:
    Dato  che esistono i seguenti utenti:
      | name                  | email                 | password  | nick   |
      | Paperino              | paolino@nomail.it     | 12345678  | Donald |
    E che esistono i seguenti eventi dell'utente "paolino@nomail.it":
      | name                  | system     | begins_at  |
      | Campionato            | Risiko     | 10-5-2012  |
    E mi loggo con email "paolino@nomail.it" e password "12345678"

  Scenario: Mostra informazioni
  Quando mi trovo nella pagina di elenco utenti
  Allora dovrei vedere "Donald" all'interno di "td"
  E dovrei vedere "1" all'interno di "td#event_count_0"
  E dovrei vedere "0" all'interno di "td#reserved_event_count_0"
  Dato che esiste la prenotazione dell'evento "Campionato" per l'utente "paolino@nomail.it"
  Quando mi trovo nella pagina di elenco utenti
  E dovrei vedere "1" all'interno di "td#reserved_event_count_0"


  Scenario: ordina gli utenti in ordine di iscrizione (default)
    Dato che esistono i seguenti utenti:
      | name                  | email                 | password  |
      | Clarabella            | clara@nomail.it       | 12345678  |
      | Pippo                 | pippo@nomail.it       | 12345678  |
      | Zorro                 | zorro@nomail.it       | 12345678  |
    Dato mi trovo nella pagina di elenco utenti
    Allora dovrei vedere "Paperino" prima di  "Clarabella"
    E dovrei vedere "Pippo" prima di  "Zorro"
    E dovrei vedere "Clarabella" prima di  "Pippo"

  Scenario: ordina gli utenti in ordine alfabetico
    Dato che esistono i seguenti utenti:
      | name                  | email                 | password  |
      | Clarabella            | clara@nomail.it       | 12345678  |
      | Pippo                 | pippo@nomail.it       | 12345678  |
      | Zorro                 | zorro@nomail.it       | 12345678  |
    Dato mi trovo nella pagina di elenco utenti
    E seguo il link "Nome"
    Allora dovrei vedere "Nome" all'interno di "th.hilite"
    E dovrei vedere "Paperino" prima di  "Pippo"
    E dovrei vedere "Pippo" prima di  "Zorro"
    Allora dovrei vedere "Clarabella" prima di  "Pippo"

Scenario: paginazione in ordine di creazione
    Dato che ci sono 28 utenti
    E che esistono i seguenti utenti:
    | name                  | email                 | password  |
    | Zorro                 | zorro@nomail.it       | 12345678  |
    | Zozzo                 | zozzo@nomail.it       | 12345678  |
    Dato mi trovo nella pagina di elenco utenti
    E dovrei vedere "Zorro"
    E dovrei non vedere "Zozzo"

Scenario: paginazione in ordine alfabetico
    Dato che ci sono 28 utenti
    E che esistono i seguenti utenti:
    | name                  | email                 | password  |
    | Zorro                 | zorro@nomail.it       | 12345678  |
    | Zozzo                 | zozzo@nomail.it       | 12345678  |
    Dato mi trovo nella pagina di elenco utenti
    E seguo il link "Nome"
    E dovrei vedere "Zorro"
    E dovrei non vedere "Zozzo"