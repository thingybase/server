class PhoneNumberVerificationPolicy < ApplicationPolicy
  def index?
    false
  end

  def show?
    false
  end

  def update?
    false
  end

  def create?
    true
  end

  def destroy?
    false
  end

  def new?
    true
  end
end
