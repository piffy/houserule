# language: it

Funzionalità:
Come utente
voglio avere una lista chiara dei miei eventi
perché posso organizzarmi meglio

Contesto: Situazione iniziale

Dato   che esistono i seguenti utenti:
| name                  | email                 | password  |
| Paperino              | paolino@nomail.it     | 12345678  |
| Pluto                 | pluto@nomail.it       | 12345678  |
E che esistono i seguenti eventi dell'utente "paolino@nomail.it":
| name                  | system     | begins_at  |
| Campionato            | Risiko     | 10-5-2013  |
| Torneo                | Monopoli   | 11-5-2013  |
| Campagna              | D&D        | 12-5-2013  |
| LAN Party             | Diablo3    | 13-5-2013  |
| Concorso              | Pandemics  | 14-5-2013  |
| Semifinale Torneo     | Scacchi    | 15-5-2013  |
E che esistono i seguenti eventi dell'utente "pluto@nomail.it":
| name                  | system     | begins_at  |
| Intruso               | Risiko     | 10-5-2013  |
E che esiste la prenotazione dell'evento "Intruso" per l'utente "paolino@nomail.it"
E che esiste la prenotazione dell'evento "Concorso" per l'utente "paolino@nomail.it"

Scenario: Mostra gli eventi dell'utente
  E vado al profilo dell'utente "paolino@nomail.it"
  E seguo il link "Eventi organizzati (6)"
  Allora dovrei vedere "Campionato"
  E dovrei vedere "Campionato"
  E dovrei vedere "Campagna"
  E dovrei vedere "Torneo"
  E dovrei non vedere "Intruso"

Scenario: Paginazione attivata
E che ci sono 30 eventi di "paolino@nomail.it"
E vado al profilo dell'utente "paolino@nomail.it"
E seguo il link "Eventi organizzati (36)"
Allora dovrei vedere "Precedente"
E dovrei vedere "Prossimo"

Scenario: Mostra gli eventi prenotati dell'utente
E vado al profilo dell'utente "paolino@nomail.it"
E seguo il link "Eventi prenotati (2)"
Allora dovrei vedere "Intruso"
E dovrei vedere "Concorso"
E dovrei non vedere "Campagna"


Scenario: ordina gli eventi in ordine di data (default)
  Dato vado alla pagina degli eventi organizzati da "paolino@nomail.it" con ordinamento "begins_at"
  Allora dovrei vedere "Campionato" prima di  "Torneo"
  E dovrei vedere "LAN Party" prima di  "Concorso"
  E dovrei vedere "Torneo" prima di  "Semifinale Torneo"

Scenario: ordina gli eventi in ordine alfabetico
  Dato vado alla pagina degli eventi organizzati da "paolino@nomail.it" con ordinamento "name"
  Allora dovrei vedere "Campionato" prima di  "Concorso"
  E dovrei vedere "Concorso" prima di  "LAN Party"
  E dovrei vedere "Semifinale Torneo" prima di  "Torneo"

Scenario: ordina gli eventi per sistema di gioco
  Dato vado alla pagina degli eventi organizzati da "paolino@nomail.it" con ordinamento "system"
  Allora dovrei vedere "Torneo" prima di  "Campionato"
  E dovrei vedere "Campagna" prima di  "LAN Party"
  E dovrei vedere "Torneo" prima di  "Concorso"






