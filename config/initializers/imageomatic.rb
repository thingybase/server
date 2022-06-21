Imageomatic.configure do |config|
  if Rails.env.production?
    # For production deployments, set the following environment keys:
    #
    # ```
    # IMAGEOMATIC_SECRET_KEY=
    # IMAGEOMATIC_PUBLIC_KEY=
    # ```
    config.load_env!
  else
    config.secret_key = "development_secret_449d1d36c75e6df2e5074234274d"
    config.public_key = "development_public_a3b61d77a85233f9068bfd39c390"
  end
end
