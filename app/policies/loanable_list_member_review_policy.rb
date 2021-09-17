class LoanableListMemberReviewPolicy < MemberReviewPolicy
  class Scope < Scope
    def resolve
      scope.where(account_id: user.accounts)
    end
  end

  private
    def is_account_owner?
      user.present? && user == record.account&.user
    end
end
