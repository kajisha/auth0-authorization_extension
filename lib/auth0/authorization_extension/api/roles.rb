module Auth0
  module AuthorizationExtension
    module Api
      module Roles
        # @see https://auth0.com/docs/api/authorization-extension#get-all-roles
        #
        # @return [json] Return the list of roles
        def roles
          get(roles_path)
        end

        # @see https://auth0.com/docs/api/authorization-extension#get-a-single-role
        #
        # @return [json] Return the role based on its unique identifier
        def role(role_id)
          get "#{roles_path}/#{role_id}"
        end

        # @see https://auth0.com/docs/api/authorization-extension#create-role
        def create_role
          raise NotImplementedError
        end

        # @see https://auth0.com/docs/api/authorization-extension#update-role
        def update_role
          raise NotImplementedError
        end

        # @see https://auth0.com/docs/api/authorization-extension#delete-role
        def delete_role
          raise NotImplementedError
        end

        private

        def roles_path
          @roles_path ||= '/roles'
        end
      end
    end
  end
end
