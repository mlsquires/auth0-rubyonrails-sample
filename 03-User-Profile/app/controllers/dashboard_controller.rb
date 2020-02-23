require 'awesome_print'

class DashboardController < ApplicationController
  include Secured
  def show
    auth_hash = session[:userinfo]
    Rails.logger.info %Q{auth0: #{self}.show: auth_hash: #{auth_hash.class.name.inspect}, #{auth_hash.awesome_inspect}}
    id_token = auth_hash['credentials']['id_token']
    decoded = auth_hash['credentials']['id_token_decoded']
    if decoded.nil?
      Rails.logger.info %Q{auth0: #{self}.show: no id_token_decoded found}
      decoded = JWT.decode(id_token,nil,false)
      Rails.logger.info %Q{auth0: #{self}.callback: decoded: #{decoded.awesome_inspect}}
      auth_hash[:id_token_decoded] = decoded
    end
    Rails.logger.info %Q{auth0: #{self}.callback: auth_hash: #{auth_hash.awesome_inspect}}
    @user = auth_hash
  end
end
