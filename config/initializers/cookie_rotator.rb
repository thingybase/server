# Rails 7.0+ defaults derive cookie keys with SHA256 instead of SHA1.
# Rotate old SHA1 cookies so existing sessions survive the framework
# defaults upgrade instead of logging everyone out. Safe to delete a few
# months after this ships, once all 30-day sessions have re-issued.
Rails.application.config.after_initialize do
  Rails.application.config.action_dispatch.cookies_rotations.tap do |cookies|
    authenticated_encrypted_cookie_salt = Rails.application.config.action_dispatch.authenticated_encrypted_cookie_salt
    signed_cookie_salt = Rails.application.config.action_dispatch.signed_cookie_salt

    secret_key_base = Rails.application.secret_key_base

    key_generator = ActiveSupport::KeyGenerator.new(
      secret_key_base, iterations: 1000, hash_digest_class: OpenSSL::Digest::SHA1
    )

    key_len = ActiveSupport::MessageEncryptor.key_len
    secret = key_generator.generate_key(authenticated_encrypted_cookie_salt, key_len)
    cookies.rotate :encrypted, secret

    signed_secret = key_generator.generate_key(signed_cookie_salt)
    cookies.rotate :signed, signed_secret
  end
end
