require 'rest-client'

require 'auth0/authorization_extension/mixins/headers'
require 'auth0/authorization_extension/mixins/httpproxy'
require 'auth0/authorization_extension/mixins/initializer'

require 'auth0/authorization_extension/api'

module Auth0
  module AuthorizationExtension
    module Mixins
      include Auth0::AuthorizationExtension::Mixins::Headers
      include Auth0::AuthorizationExtension::Mixins::HTTPProxy
      include Auth0::AuthorizationExtension::Mixins::Initializer
    end
  end
end
