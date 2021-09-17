class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    is_user?
  end

  def show?
    is_user? && scope.where(id: record.id).exists?
  end

  def create?
    is_user?
  end

  def new?
    create?
  end

  def update?
    is_owner?
  end

  def edit?
    update?
  end

  def destroy?
    is_owner?
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.where(user_id: @user)
    end
  end

  private
    def is_user?
      user.present?
    end

    def is_owner?
      is_user? && user == record_owner
    end

    def is_account_owner?
      is_user? && user == account_owner
    end

    def is_account_member?
      is_user? && user.accounts.where(id: account).exists?
    end

    def account
      record.account
    end

    def account_owner
      account.user
    end

    def record_owner
      record.user
    end
end
