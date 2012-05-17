def login(user)
  visit login_path
  fill_in "session_email",    with: user.email
  fill_in "session_password", with: user.password
  click_button "Login"
  # Sign in when not using Capybara as well.
  cookies[:remember_token] = user.remember_token
end