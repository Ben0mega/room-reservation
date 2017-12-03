OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'],
  {
      provider_ignores_state: true,
      hd: 'berkeley.edu',
      :client_options => {:ssl => {:ca_file => 'lib/assests/cacert.pem'}}
  }
  
end