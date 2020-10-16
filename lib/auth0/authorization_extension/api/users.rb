module Auth0
  module AuthorizationExtension
    module Api
      module Users
        # @see https://auth0.com/docs/api/authorization-extension#get-all-users
        def users(options = {})
          request_params = {
            per_page: options.fetch(:per_page, nil),
            page: options.fetch(:page, nil)
          }
          get(users_path, request_params)
        end

        # @see https://auth0.com/docs/api/authorization-extension#get-a-single-user
        # Add "?expand" to also load all roles and permissions for these groups.
        # @param user_id [string] The id of the user to retrieve.
        #
        # @return [json] Return the user based on its unique identifier.
        def user(user_id)
          raise NotImplementedError
        end

        # @see https://auth0.com/docs/api/authorization-extension#get-user-groups
        # @param user_id [string] The id of the user to retrieve
        #
        # @return [json] the groups of a single user, based on its unique identifier.
        def user_groups(user_id)
          get "#{users_path}/#{user_id}/groups"
        end

        # @see https://auth0.com/docs/api/authorization-extension#add-user-to-groups
        # @param user_id [string] The id of the user that you want to add to groups.
        # @param group_ids [array] The ids of the group to which you want to add the user.
        #
        # @return [json]
        def add_user_to_groups(user_id, group_ids)
          patch "#{users_path}/#{user_id}/groups", group_ids
        end

        # @see https://auth0.com/docs/api/authorization-extension#calculate-group-memberships
        # @param user_id [string] The id of the user for whom you want to calculate the group memberships
        #
        # @return [json] Return calculation results of the group memberships for a user (including nested groups).
        def calculate_group_memberships(user_id)
          raise NotImplementedError
        end

        # @see https://auth0.com/docs/api/authorization-extension#get-user-roles
        # @param user_id [string] The id of the user for whom you want to retrieve the roles
        #
        # @return [json] Return the roles of a single user, based on its unique identifier.
        def user_roles(user_id)
          raise NotImplementedError
        end

        # @see https://auth0.com/docs/api/authorization-extension#add-user-to-roles
        # @param user_id [string] The id of the user that you want to assign to roles
        # @param role_ids [array] The id of the role to which you want to assign users
        #
        def add_user_to_roles(user_id, role_ids)
          raise NotImplementedError
        end

        # @see https://auth0.com/docs/api/authorization-extension#remove-user-from-roles
        # @param user_id [string] The id of the user you want to remove from roles
        # @param role_ids [array] The id of the role(s) you want to remove users from
        def remove_user_from_roles(user_id, role_ids)
          raise NotImplementedError
        end

        # @see https://auth0.com/docs/api/authorization-extension#calculate-roles
        # @param user_id [string] The id of the user for whom you want to calculate the roles
        #
        # @return [json] Return calculation results of the roles assigned to the user (including through group memberships).
        def calculate_roles(user_id)
          raise NotImplementedError
        end

        # @see https://auth0.com/docs/api/authorization-extension#execute-authorization-policy
        def execute_authorization_policy
          raise NotImplementedError
        end

        private

        def users_path
          @users_path ||= '/users'
        end
      end
    end
  end
end
