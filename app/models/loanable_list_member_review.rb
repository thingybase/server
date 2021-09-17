class LoanableListMemberReview < ApplicationModel
  attr_accessor :loanable_list_member_request, :loanable_list_member, :status

  delegate :user, :loanable_list, :created_at, to: :loanable_list_member_request
  delegate :name, :email, to: :user
  delegate :account, to: :loanable_list

  validates :status, presence: true
  validates :status, inclusion: %w[accept decline]
  validates :user, presence: true
  validates :loanable_list, presence: true

  def save
    transition_state if valid?
  end

  def accepted?
    status == "accept"
  end

  private
    def transition_state
      LoanableList.transaction do
        loanable_list_member = loanable_list.members.create!(user: user) if create_member?
        loanable_list_member_request.destroy
      end
    end

    def is_member?
      loanable_list.members.where(user: user).exists?
    end

    def create_member?
      accepted? and not is_member?
    end
end
