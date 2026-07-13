# Signs users in through the real OmniAuth callback so request specs
# exercise the same session code paths as production.
OmniAuth.config.test_mode = true
OmniAuth.config.logger = Logger.new(File::NULL)

module AuthenticationHelpers
  def sign_in(user)
    auth_hash = OmniAuth::AuthHash.new(
      provider: "google_oauth2",
      uid: "123456789",
      info: { email: user.email, name: user.name }
    )
    OmniAuth.config.mock_auth[:google_oauth2] = auth_hash
    Rails.application.env_config["omniauth.auth"] = auth_hash
    post "/auth/google_oauth2/callback"
  end
end

RSpec.configure do |config|
  config.include AuthenticationHelpers, type: :request

  config.after(type: :request) do
    Rails.application.env_config.delete("omniauth.auth")
    OmniAuth.config.mock_auth[:google_oauth2] = nil
  end
end
