require 'json'
require 'awesome_print'
require 'jwt'

class Auth0Controller < ApplicationController
  def callback
    # OmniAuth places the User Profile information (retrieved by omniauth-auth0) in request.env['omniauth.auth'].
    # In this tutorial, you will store that info in the session, under 'userinfo'.
    # If the id_token is needed, you can get it from session[:userinfo]['credentials']['id_token'].
    # Refer to https://github.com/auth0/omniauth-auth0#auth-hash for complete information on 'omniauth.auth' contents.
    auth_hash = request.env['omniauth.auth']
    Rails.logger.info %Q{auth0: #{self}.callback: auth_hash: #{auth_hash.class.name.inspect}, #{auth_hash.awesome_inspect}}
    session[:userinfo] = auth_hash
#     id_token = auth_hash['credentials']['id_token']
#     decoded = JWT.decode(id_token,nil,false)
#     Rails.logger.info %Q{auth0: #{self}.callback: decoded: #{decoded.awesome_inspect}}
#     auth_hash[:jwt] = decoded
#     Rails.logger.info %Q{auth0: #{self}.callback: auth_hash: #{auth_hash.awesome_inspect}}
# 
#     session[:userinfo] = JSON.pretty_generate(auth_hash)

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
