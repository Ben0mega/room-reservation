Given /I am not logged in/ do
  
end

Given /I am logged in as "(.*)", "(.*)"/ do |username, user_email|
  first_name, last_name = username.split
  stub_omniauth(first_name, last_name, user_email)
  visit "/auth/google_oauth2/callback"
end

Then /I should see the homepage with "(.*)"/ do |message|
  expect(page).to have_content(message)
  expect(page).to have_current_path(buildings_path)
end

def stub_omniauth(first_name, last_name, email_id) 
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
    provider: "google_oauth2",
    uid: "12345678910",
    info: {
      email: email_id,
      first_name: first_name,
      last_name: last_name
    },
    credentials: {
      token: "abcdefg12345",
      refresh_token: "12345abcdefg",
      expires_at: DateTime.now,
    }        
  })
end