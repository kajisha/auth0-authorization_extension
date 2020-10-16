module Auth0
  module AuthorizationExtension
    module Api
      module Permissions
        # @see https://auth0.com/docs/api/authorization-extension#get-all-permissions
        #
        # @return [json] Return the list of permissions
        def permissions
          get(permissions_path)
        end

        # @see https://auth0.com/docs/api/authorization-extension#get-a-single-permission
        # @param permission_id [string] The id of the permission to retrieve.
        #
        # @return [json] Return the permission based on its unique identifier.
        def permission(permission_id)
          get "#{permissions_path}/#{permission_id}"
        end

        # @see https://auth0.com/docs/api/authorization-extension#create-permission
        def create_permission
          raise NotImplementedError
        end

        # @see https://auth0.com/docs/api/authorization-extension#update-permission
        def update_permission
          raise NotImplementedError
        end

        # @see https://auth0.com/docs/api/authorization-extension#delete-permission
        def delete_permission
          raise NotImplementedError
        end

        private

        def permissions_path
          @permissions_path ||= '/permissions'
        end
      end
    end
  end
end
