Rails.application.config.middleware.use OmniAuth::Builder do
  scopes = %w[ ]

  provider(
    :auth0,
    ENV['AUTH0_CLIENT_ID'],
    ENV['AUTH0_CLIENT_SECRET'],
    ENV['AUTH0_DOMAIN'],
    callback_path: '/auth/auth0/callback',
    authorize_params: {
      scope: scopes.join(%q{ })
    }
  )
end
OmniAuth::Strategies::Auth0.configure( { skip_info: true } )
