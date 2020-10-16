require 'auth0'

module Auth0
  module AuthorizationExtension
    module Mixins
      module Initializer
        # @param config [hash] Following parameters are required
        #   * :extension_url [string]
        #   * :client_id [string]
        #   * :client_secret [string]
        #   * :audience [string]
        #   * :domain [string]
        def initialize(config)
          options = Hash[config.map { |(k, v)| [k.to_sym, v] }]
          @base_uri = base_url(options)
          @headers = client_headers
          @timeout = options[:timeout] || 10
          @client_id = options[:client_id]
          @client_secret = options[:client_secret]
          @audience = options[:audience]
          @domain = options[:domain]
          initialize_api
        end

        def self.included(klass)
          klass.send :prepend, Initializer
        end

        def authorization_header
          add_headers('Authorization' => "Bearer #{api_token.token}")
        end

        def initialize_api
          extend Auth0::AuthorizationExtension::Api

          authorization_header
        end

        def base_url(options)
          "https://#{options[:extension_url]}"
        end

        private

        def api_token
          management_api_client.api_token(audience: @audience)
        end

        def management_api_client
          @management_api_client ||= Auth0::Client.new(client_id: @client_id, client_secret: @client_secret, domain: @domain)
        end
      end
    end
  end
end
