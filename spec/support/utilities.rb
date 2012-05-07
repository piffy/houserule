def login(user)
  visit login_path
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Login"
  # Sign in when not using Capybara as well.
  cookies[:remember_token] = user.remember_token
end