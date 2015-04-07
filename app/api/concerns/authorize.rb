# app/api/concerns/authorize.rb

# Authorize helper for API
#

module Concerns

  module Authorize

    extend ActiveSupport::Concern

    included do

      helpers do

        # Find pundit policy for scope
        #
        # @param [User]
        # @param [ActiveRecord_Relation] scope
        #
        # @return [Policy] policy
        #
        # :nocov:
        def find_policy_scope(user, scope)
          policy_scope = ::Pundit::PolicyFinder.new(scope).scope
          policy_scope.new(user, scope).resolve if policy_scope
        end
        # :nocov:

        # Find pundit policy for scope
        #
        # @param [User]
        # @param [ActiveRecord_Relation] scope
        #
        # @return [Policy] policy
        #
        # :nocov:
        def find_policy_scope!(user, scope)
          ::Pundit::PolicyFinder.new(scope).scope!.new(user, scope).resolve
        end
        # :nocov:

        # Find pundit policy for record
        #
        # @param [User]
        # @param [ActiveRecordBase] record
        #
        # @return [Policy] policy
        #
        # :nocov:
        def find_policy(user, record)
          policy = ::Pundit::PolicyFinder.new(record).policy
          policy.new(user, record) if policy
        end
        # :nocov:

        # Find pundit policy for record
        #
        # @param [User]
        # @param [ActiveRecordBase] record
        #
        # @return [Policy] policy
        #
        def find_policy!(user, record)
          ::Pundit::PolicyFinder.new(record).policy!.new(user, record)
        end

        # Find pundit policy for record
        #
        # @param [ActiveRecord_Relation] scope
        #
        # @return [Policy] policy
        #
        # :nocov:
        def policy_scope(scope)
          @pundit_policy_scoped = true
          policy_scopes[scope] ||= find_policy_scope!(pundit_user, scope)
        end
        # :nocov:

        # Find pundit policy for record
        #
        # @param [ActiveRecordBase] record
        #
        # @return [Policy] policy
        #
        def policy(record)
          policies[record] ||= find_policy!(pundit_user, record)
        end

        # Memoize policies from records
        #
        # @return [Hash] policies
        #
        def policies
          @pundit_policies ||= {}
        end

        # Memoize policies from scopes
        #
        # @return [Hash] policies
        #
        # :nocov:
        def policy_scopes
          @pundit_policy_scopes ||= {}
        end
        # :nocov:

        # Pundit current user
        #
        # @return [User] current pundit user
        #
        def pundit_user
          current_user
        end

        # Authorize scope
        #
        # @param [ActiveRecord_Relation] scope
        #
        # @return [ActiveRecord_Relation] authorized scope
        #
        def authorized(scope)
          policy_scope(scope)
        end

        # Authorize record for action
        #
        # @param [ActiveRecordBase] record
        # @param [Symbol] action
        #
        # @return [Boolean] authorized for action
        #
        def authorize(record, action=nil)
          action ||= params[:action].to_s + "?"
          policy = policy(record)
          policy.public_send(action)
        end

        # Authorize or force error
        #
        def authorize!(record, action)
          error!({error:  'Forbidden',
                  detail: "Not authorized for resource",
                  status: '403'},
                 403) unless authorize record, action
        end

        # Exists or force error
        #
        # @return [ActiveRecordBase] existing object
        #
        def exists!(object)
          error!({error:  'Not Found',
                  detail: "Resource can not be found",
                  status: '404'},
                 403)  unless object
          object
        end

      end

    end

  end # Authorize

end # Concerns
