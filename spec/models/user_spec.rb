require 'rails_helper'

RSpec.describe User, type: :model do
    describe 'assigns as per omniauth' do
        it 'creates a user instance when logging in' do
           stub_omniauth 
           User.from_omniauth(OmniAuth.config.mock_auth[:google])
           expect(User.count).to eq(1)
        end
    end
end

def stub_omniauth 
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new({
      provider: "google",
      uid: "12345678910",
      info: {
        email: "jesse@mountainmantechnologies.com",
        first_name: "Jesse",
        last_name: "Spevack"
      },
      credentials: {
        token: "abcdefg12345",
        refresh_token: "12345abcdefg",
        expires_at: DateTime.now,
      }        
    })
end
