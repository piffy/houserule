# language: it
Funzionalità: Invio email
  Come utente
  Voglio poter ricevere email
  Per tenere sotto controllo la situazione

@email
  Scenario: Invio mail di registrazione
  Dato   mi trovo nella pagina di registrazione
  Quando inserisco in "user_name" "Paperino"
  E      inserisco in "user_email" "paolino@nomail.it"
  E      inserisco in "user_password" "12345678"
  E      inserisco in "user_password_confirmation" "12345678"
  Quando premo "Crea utente"
  Allora dovrebbe spedire una "conferma di registrazione" via e-mail a "paolino@nomail.it"

