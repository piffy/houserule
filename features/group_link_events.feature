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
  | Estraneo              | estraneo@nomail.it       | 12345678  |

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
    Quando seguo il link "Collega"
    E premo il pulsante "button_1"
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
    Quando seguo il link "Collega"
    Quando premo il pulsante "button_1"
    Allora dovrei vedere "ora collegato al gruppo"
    E dovrei essere nella pagina di dettagli del gruppo "Gruppo 1"
    E dovrei vedere "Eventi collegati: (1)"

  Scenario:   Slinkare evento dal gruppo
    Dato mi loggo con email "paolino@nomail.it" e password "12345678"
    E un evento è collegato al gruppo "Gruppo 1"
    Dato    vado alla visualizzazione gruppo di "Gruppo 1"
    Quando seguo il link "-"
    E premo il pulsante "Elimina"


   Scenario: Non è possibile cancellare o creare un link se non si hanno i diritti del gruppo
    Dato mi loggo con email "estraneo@nomail.it" e password "12345678"
    Dato un evento è collegato al gruppo "Gruppo 1"
    Dato    vado alla visualizzazione gruppo di "Gruppo 1"
    Quando seguo il link "-"
    Allora dovrei vedere "Azione non consentita"
    #Non posso ancora testare il post con capybara


Scenario: Controllo accesso (non loggato)
    Dato un evento è collegato al gruppo "Gruppo 1"
    Dato    vado alla visualizzazione gruppo di "Gruppo 1"
    Allora dovrei non vedere "Collega evento" all'interno di "a"
    Quando mi trovo nella pagina di collegamento di un gruppo
    Allora dovrei essere nella pagina di login


Scenario:  Creare un evento legato al gruppo (se si fa parte del gruppo)
  Dato mi loggo con email "pippo@nomail.it" e password "12345678"
  Dato    vado alla visualizzazione gruppo di "Gruppo 1"
  Allora dovrei vedere "Organizza evento collegato" all'interno di "a"
  Quando seguo il link "Organizza evento collegato"
  E dovrei vedere "Questo evento sarà collegato al gruppo 'Gruppo 1'"
  Dato   inserisco in "event_name" "Nuovo Evento"
  Quando premo "Prossimo"
  Allora dovrei vedere "Evento creato!"
  E dovrei vedere "L'evento, inoltre, è collegato al gruppo"
