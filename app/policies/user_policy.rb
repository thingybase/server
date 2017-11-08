class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(id: @user)
    end
  end

  private
    def is_owner?
      @user == @record
    end
end
