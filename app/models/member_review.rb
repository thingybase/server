class MemberReview < ApplicationModel
  attr_accessor :member_request, :member, :status

  delegate :user, :account, :created_at, :id, to: :member_request
  delegate :name, :email, to: :user

  validates :status, presence: true
  validates :status, inclusion: %w[accept decline]
  validates :user, presence: true
  validates :account, presence: true

  def save
    transition_state if valid?
  end

  def accepted?
    status == "accept"
  end

  private
    def transition_state
      Account.transaction do
        self.member = account.members.create!(user: user) if create_member?
        member_request.destroy
      end
    end

    def is_member?
      account.members.where(user: user).exists?
    end

    def create_member?
      accepted? and not is_member?
    end
end
