# language: it

Funzionalità:
  Come responsabile di gruppo o convention
  voglio poter legare un evento al mio gruppo
  perché voglio dare visibilità al gruppo

  Contesto: Esiste un gruppo

  Dato   che esistono i seguenti utenti:
  | name                  | email                 | password  |
  | Paperino              | paolino@nomail.it     | 12345678  |
  | Pippo                 | pippo@nomail.it       | 12345678  |

  E che esistono i seguenti gruppi di "pippo@nomail.it":
    | name                  | description               |
    | Gruppo 1              | Un grande gruppo          |

  E a "Paperino" interessa il gruppo "Gruppo 1"

  E ci sono 3 eventi di "paolino@nomail.it"

  Scenario:   Linkare un evento al gruppo (se si fa parte del gruppo e si amministra un evento)
    Dato mi loggo con email "paolino@nomail.it" e password "12345678"
    Dato    vado alla visualizzazione gruppo di "Gruppo 1"
    Allora dovrei vedere "Collega evento" all'interno di "a"
    Quando seguo il link "Collega evento"
    Allora dovrei vedere il titolo "Collega evento"
    Quando premo il pulsante "button_1"
    Allora dovrei vedere "ora collegato al gruppo"
    E dovrei essere nella pagina di dettagli del gruppo "Gruppo 1"
    E dovrei vedere "Eventi collegati: (1)"
    Quando vado ai dettagli di un evento
    Allora dovrei vedere "Legato a:"
    E dovrei vedere "Gruppo 1"
    E dovrei vedere "" all'interno di "img.tiny-group-logo"

  Scenario:  Linkare un evento al gruppo (se si amministra il gruppo)
    Dato mi loggo con email "pippo@nomail.it" e password "12345678"
    Dato    vado alla visualizzazione gruppo di "Gruppo 1"
    Allora dovrei vedere "Collega evento" all'interno di "a"
    Quando seguo il link "Collega evento"
    Allora dovrei vedere il titolo "Collega evento"
    Quando premo il pulsante "button_1"
    Allora dovrei vedere "ora collegato al gruppo"
    E dovrei essere nella pagina di dettagli del gruppo "Gruppo 1"
    E dovrei vedere "Eventi collegati: (1)"

  Scenario:   Slinkare evento dal gruppo
    Dato mi loggo con email "paolino@nomail.it" e password "12345678"
    E un evento è collegato al gruppo "Gruppo 1"
    Dato    vado alla visualizzazione gruppo di "Gruppo 1"
    Quando seguo il link "-"
    Quando premo il pulsante "Elimina"


  Scenario: Non è possibile linkare evento due volte


  Scenario: Non è possibile modificare link se non si hanno i diritti del gruppo

  Scenario: Se l'evento è linkato visualizzare icona e link nella pagina dettagli

  Scenario: Visualizzare eventi linkati nella pagina dettaglio del gruppo

  Scenario: Filtrare eventi per gruppi

  Scenario: Controllo accesso

  #Se convention, link esclusivo
  #Se convention, possibile iscrizione esclusiva



