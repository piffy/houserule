Then /^non sono loggato come utente "(\w+)"/ do |utente|
  "dovrei non vedere \"#{utente}\""
end

Given /^mi loggo con email "([^"]*)" e password "([^"]*)"$/ do |utente, password|
  "mi trovo nella pagina di login"
  "inserisco in \"session_email\" \"#{utente}\""
  "inserisco in \"session_password\" \"#{password}\""
  "inserisco in \"session_password_confirmation\" \"#{password}\""
  "premo \"Login\""
  "dovrei vedere \"Profilo\""
end

