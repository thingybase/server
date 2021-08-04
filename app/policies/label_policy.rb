class LabelPolicy < ItemPolicy
  def initialize(user, record)
    @user = user
    @record = record.item
  end

  def scan?
    true
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = Item
    end

    def resolve
      scope.where(user_id: @user)
    end
  end
end
