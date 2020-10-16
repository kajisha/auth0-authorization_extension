require 'json'

module Auth0
  module AuthorizationExtension
    module Mixins
      module Headers
        def client_headers
          {
            'Content-Type' => 'application/json'
          }
        end
      end
    end
  end
end
