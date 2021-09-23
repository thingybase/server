class MemberReviewPolicy < BaseAccountOwnerPolicy
  class Scope < Scope
    def scope
      MemberRequest
    end
  end
end
