module Concerns

  module Authorize

    extend ActiveSupport::Concern

    included do

      helpers do

        def find_policy_scope(user, scope)
          policy_scope = ::Pundit::PolicyFinder.new(scope).scope
          policy_scope.new(user, scope).resolve if policy_scope
        end

        def find_policy_scope!(user, scope)
          ::Pundit::PolicyFinder.new(scope).scope!.new(user, scope).resolve
        end

        def find_policy(user, record)
          policy = ::Pundit::PolicyFinder.new(record).policy
          policy.new(user, record) if policy
        end

        def find_policy!(user, record)
          ::Pundit::PolicyFinder.new(record).policy!.new(user, record)
        end

        def policy_scope(scope)
          @pundit_policy_scoped = true
          policy_scopes[scope] ||= find_policy_scope!(pundit_user, scope)
        end

        def policy(record)
          policies[record] ||= find_policy!(pundit_user, record)
        end

        def policies
          @pundit_policies ||= {}
        end

        def policy_scopes
          @pundit_policy_scopes ||= {}
        end

        def pundit_user
          current_user
        end

        def authorized(scope)
          policy_scope(scope)
        end

        def authorize(record, action=nil)
          action ||= params[:action].to_s + "?"
          policy = policy(record)
          policy.public_send(action)
        end

        def authorize!(record, action)
          error!({ error:  'Forbidden',
                   detail: "Not authorized for resource",
                   status: '403'},
                 403) unless authorize record, action
        end

        def exists!(object)
          error!({ error:  'Not Found',
                   detail: "Resource can not be found",
                   status: '404'},
                 403)  unless object
          object
        end

      end

    end

  end # Authorize

end # Concerns
