require 'json'
require 'jwt'

class Auth0Controller < ApplicationController
  def callback
    # OmniAuth places the User Profile information (retrieved by omniauth-auth0) in request.env['omniauth.auth'].
    # In this tutorial, you will store that info in the session, under 'userinfo'.
    # If the id_token is needed, you can get it from session[:userinfo]['credentials']['id_token'].
    # Refer to https://github.com/auth0/omniauth-auth0#auth-hash for complete information on 'omniauth.auth' contents.
    userinfo = JSON.load(request.env['omniauth.auth'])
    id_token = userinfo['credentials']['id_token']
    userinfo[:jwt] = JWT.decode(id_token,nil,false)

    session[:userinfo] = JSON.pretty_generate(userinfo)

    redirect_to '/dashboard'
  end

  # if user authentication fails on the provider side OmniAuth will redirect to /auth/failure,
  # passing the error message in the 'message' request param.
  def failure
    @error_msg = request.params['message']
  end
end

def dump_jwt(jwt)
  # Set password to nil and validation to false otherwise this won't work
  decoded = JWT.decode jwt, nil, false
  Rails.logger.info %Q{auth0: #{self}.dump_jwt: decoded: #{decoded.awesome_inspect}}
rescue JWT::DecodeError
  Rails.logger.info %Q{auth0: #{self}.dump_jwt: received invalid jwt}
end
