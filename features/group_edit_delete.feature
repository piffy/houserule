# language: it
Funzionalità: Modifica gruppo
Come gestore di un gruppo
Voglio potermi modificarlo o cancellarlo
Per tenere aggiornata la situazion

Contesto:
Dato   che esistono i seguenti utenti:
| name                  | email                 | password  | password_confirmation | nick | location   |  description |
| Paperino              | paolino@nomail.it     | 12345678  | 12345678              | pap  | Paperopoli |  Papero      |
| Pippo                 | pippo@nomail.it       | 12345678  | 12345678              | pap  | Paperopoli |  Papero      |

E che esistono i seguenti gruppi di "paolino@nomail.it":
| name                  | description               |
| Gruppo 1              | Un grande gruppo          |


Scenario:   Navigazione e Modifica
  Dato mi loggo con email "paolino@nomail.it" e password "12345678"
  E    vado alla modifica gruppo di "Gruppo 1"
  Allora dovrei vedere il titolo "Modifica gruppo"
  Quando inserisco in "group_name" "Un nome cambiato"
  E      inserisco in "group_description" "Una descrizione modificata"
  E      inserisco in "group_website_url" "http://www.example.com"
  E      inserisco in "group_image_url" "http://images1.informazione.it/OO2o4kTgOElXZx88CZ0u80LjbZ83C1CYkKW2cePI9Qi1udl0oESef2IoG29j0CnJ"
  E      inserisco in "group_mailing_list" "mailing_list@email.it"
  E      seleziono la casella "group_is_convention"
  Quando premo "Invia"
  Allora  dovrei essere nella pagina di dettagli del gruppo "Un nome cambiato"
  E dovrei vedere "Gruppo modificato"
  Quando      vado alla pagina di elenco gruppo
  Allora dovrei vedere "Un nome cambiato"
  E      dovrei vedere "" all'interno di "i.icon-calendar"

Scenario: Troncamento descrizione lunga nell'elenco
  Dato mi loggo con email "paolino@nomail.it" e password "12345678"
  E    vado alla modifica gruppo di "Gruppo 1"
  E    inserisco in "group_description" "Una descrizione moooolto lunga: blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah"
  E premo "Invia"
  Quando vado alla pagina di elenco gruppo
  Allora dovrei vedere "..." all'interno di "td"

  Scenario:  Non inserisco il nome
  Dato mi loggo con email "paolino@nomail.it" e password "12345678"
  E    vado alla modifica gruppo di "Gruppo 1"
  E      inserisco in "group_name" ""
  Quando premo "Invia"
  Allora dovrei vedere il messaggio di errore "Name non può essere lasciato in bianco"

  Scenario:  Indirizzo mailing list errato
    Dato mi loggo con email "paolino@nomail.it" e password "12345678"
    E    vado alla modifica gruppo di "Gruppo 1"
    E      inserisco in "group_mailing_list" "ERRORE"
    Quando premo "Invia"
    Allora dovrei vedere il messaggio di errore "Mailing list non è valido"

Scenario:   Non loggato (redirect amichevole)
  Dato    vado alla modifica gruppo di "Gruppo 1"
  Allora dovrei essere nella pagina di login
  Quando mi loggo con email "paolino@nomail.it" e password "12345678"
  Allora dovrei essere nella pagina di modifica del gruppo "Gruppo 1"

Scenario:   Altro utente
  Dato   mi loggo con email "pippo@nomail.it" e password "12345678"
  Dato    vado alla modifica gruppo di "Gruppo 1"
  Allora  dovrei vedere "Azione non consentita"


Scenario:   Eliminazione Gruppo (con navigazione)
  Dato mi loggo con email "paolino@nomail.it" e password "12345678"
  E      vado alla modifica gruppo di "Gruppo 1"
  E      dovrei vedere il pulsante "Elimina"
  Quando vado alla eliminazione del gruppo "Gruppo 1"
  E      vado alla pagina di elenco gruppo
  Allora dovrei non vedere "Gruppo 1"


