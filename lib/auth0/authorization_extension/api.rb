require 'auth0/authorization_extension/api/groups'
require 'auth0/authorization_extension/api/roles'
require 'auth0/authorization_extension/api/permissions'
require 'auth0/authorization_extension/api/users'

module Auth0
  module AuthorizationExtension
    module Api
      include Auth0::AuthorizationExtension::Api::Groups
      include Auth0::AuthorizationExtension::Api::Roles
      include Auth0::AuthorizationExtension::Api::Permissions
      include Auth0::AuthorizationExtension::Api::Users
    end
  end
end
