class MovePolicy < BaseAccountOwnerPolicy
  def show?
    is_account_member? and is_record_in_scope?
  end

  def index?
    show?
  end
end
