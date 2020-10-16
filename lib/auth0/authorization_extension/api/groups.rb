module Auth0
  module AuthorizationExtension
    module Api
      module Groups
        # @see https://auth0.com/docs/api/authorization-extension#get-all-groups
        #
        # @return [json] Return the list of existing groups.
        def groups
          get(groups_path)
        end

        # @see https://auth0.com/docs/api/authorization-extension#get-a-single-group
        # @param group_id [string] The id of the group to retrieve.
        #
        # @return [json] Returns the group with the given group_id if it exists.
        def group(group_id)
          raise ArgumentError, 'Must supply a valid group_id' if group_id.to_s.empty?

          get "#{groups_path}/#{group_id}"
        end

        # @see https://auth0.com/docs/api/authorization-extension#create-group
        # @param group_name [string] The name of the new group.
        # @param data [hash]
        #   * :description [string] A description of the new group.
        # @return [json] Return the created group.
        def create_group(group_name, data = {})
          raise ArgumentError, 'Must supply a valid group_name' if group_name.to_s.empty?
          raise ArgumentError, 'Must supply a valid description' if data[:description].nil?

          data[:name] = group_name
          post(groups_path, data)
        end

        # @see https://auth0.com/docs/api/authorization-extension#delete-group
        # @param group_id [string] The group_id of the group to delete.
        def delete_group(group_id)
          raise ArgumentError, 'Must supply a valid group_id' if group_id.to_s.empty?

          delete "#{groups_path}/#{group_id}"
        end

        # @see https://auth0.com/docs/api/authorization-extension#update-group
        # @param data [hash]
        #   * :name [string] The updated group name
        #   * :description [string] The updated group description
        #
        # @return [json] Return the updated group.
        def update_group(group_id, data = {})
          raise ArgumentError, 'Must supply a valid group_id' if group_id.to_s.empty?

          put "#{groups_path}/#{group_id}", data
        end

        # @see https://auth0.com/docs/api/authorization-extension#get-group-mappings
        # @param group_id [string] The id of the group whose mappings you want to retrieve
        #
        # @return [json] Return the mapping of the group
        def group_mappings(group_id)
          raise NotImplementedError
        end

        # @see https://auth0.com/docs/api/authorization-extension#create-group-mappings
        # @param group_id [string]
        # @param data [hash]
        #   * :group_name [string] Group to add the users to
        #   * :connection_name [string] Connection for the mapping
        #
        # @return [json]
        def create_group_mappings(group_id, data)
          raise NotImplementedError
        end

        # @see https://auth0.com/docs/api/authorization-extension#delete-group-mappings
        # @param group_id [string]
        # @param group_mapping_ids [array]
        def delete_group_mappings(group_id, group_mapping_ids)
          raise NotImplementedError
        end

        # @see https://auth0.com/docs/api/authorization-extension#get-group-members
        # @param group_id [string] The  group_id of the members to retrieve.
        #
        # @return [json] Return the list of existing members with the given group_id if it is exists.
        def group_members(group_id, options = {})
          raise ArgumentError, 'Must supply a valid group_id' if group_id.to_s.empty?

          request_params = {
            per_page: options.fetch(:per_page, nil),
            page: options.fetch(:page, nil)
          }
          get "#{groups_path}/#{group_id}/members", request_params
        end

        # @see https://auth0.com/docs/api/authorization-extension#add-group-members
        # @param group_id [string] The id of the group to which you want to add members
        # @param data [array] Id of the user to add in a group
        def add_group_members(group_id, data)
          raise ArgumentError, 'Must supply a valid group_id' if group_id.to_s.empty?

          patch "#{groups_path}/#{group_id}/members", data
        end

        # @see https://auth0.com/docs/api/authorization-extension#delete-group-members
        # @param group_id [string] The id of the group to which you want to add members
        # @param data [array] Id of the user to delete in a group
        def delete_group_members(group_id, data)
          raise ArgumentError, 'Must supply a valid group_id' if group_id.to_s.empty?

          delete_with_body "#{groups_path}/#{group_id}/members", data
        end

        # @see https://auth0.com/docs/api/authorization-extension#get-nested-group-members
        def nested_group_members(group_id)
          raise NotImplementedError
        end

        # @see https://auth0.com/docs/api/authorization-extension#get-nested-groups
        def nested_groups(group_id)
          raise NotImplementedError
        end

        # @see https://auth0.com/docs/api/authorization-extension#add-nested-groups
        def add_nested_groups(group_id, group_ids)
          raise NotImplementedError
        end

        # @see https://auth0.com/docs/api/authorization-extension#delete-nested-groups
        def delete_nested_groups(group_id, nested_group_ids)
          raise NotImplementedError
        end

        # @see https://auth0.com/docs/api/authorization-extension#get-group-roles
        # @param group_id The group_id of the roles to retrieve.
        #
        # @return [json] Return the list of roles with given group_id if it is exists.
        def group_roles(group_id)
          raise ArgumentError, 'Must supply a valid group_id' if group_id.to_s.empty?

          get "#{groups_path}/#{group_id}/roles"
        end

        # @see https://auth0.com/docs/api/authorization-extension#get-group-roles
        def group_roles(group_id)
          raise ArgumentError, 'Must supply a valid group_id' if group_id.to_s.empty?

          get "#{groups_path}/#{group_id}/roles"
        end

        # @see https://auth0.com/docs/api/authorization-extension#add-group-roles
        # @param group_id [string] The group_id of the roles to add.
        # @param role_ids [array] Array of string role ids to add the group
        #
        # @return [json] Return the list of roles with given group_id.
        def add_group_roles(group_id, role_ids)
          raise ArgumentError, 'Must supply a valid group_id' if group_id.to_s.empty?
          raise ArgumentError, 'Must supply a valid role_ids' if role_ids.empty?

          patch "#{groups_path}/#{group_id}/roles", role_ids
        end

        # @see https://auth0.com/docs/api/authorization-extension#delete-group-roles
        # @param group_id [string] The group_id of the roles to delete.
        # @param role_ids [array] Array of string role ids to delete the group
        def delete_group_roles(group_id, role_ids)
          raise ArgumentError, 'Must supply a valid group_id' if group_id.to_s.empty?
          raise ArgumentError, 'Must supply a valid role_ids' if role_ids.empty?

          delete_with_body "#{groups_path}/#{group_id}/roles", role_ids
        end


        # @see https://auth0.com/docs/api/authorization-extension#get-nested-group-roles
        # @param group_id [string] The id of the group from which the nested members will be retrieved
        def nested_group_roles(group_id)
          raise ArgumentError, 'Must supply a valid group_id' if group_id.to_s.empty?

          get "#{groups_path}/#{group_id}/roles/nested"
        end

        private

        def groups_path
          @groups_path ||= '/groups'
        end
      end
    end
  end
end
