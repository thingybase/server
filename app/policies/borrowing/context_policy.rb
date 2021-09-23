module Borrowing
  class ContextPolicy < ::ApplicationPolicy
    class Scope < ApplicationPolicy::Scope
      def resolve
        scope.joins(:members).where members: { user: user }
      end
    end
  end
end
