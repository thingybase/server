class PhoneNumberVerificationPolicy < ApplicationPolicy
  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def destroy?
    false
  end
end
