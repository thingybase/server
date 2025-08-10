class User < ApplicationRecord
  validates :name, presence: true
  validates :email,
    presence: true,
    uniqueness: true,
    format: { with: URI::MailTo::EMAIL_REGEXP }
  phony_normalize :phone_number, default_country_code: 'US'
  validates :phone_number,
    phony_plausible: true,
    uniqueness: true,
    allow_nil: true


  has_many :items
  has_many :members
  has_many :loanable_list_members
  has_many :loanable_lists, through: :loanable_list_members

  # Accounts the user belongs to, but doesn't own.
  has_many :member_accounts, through: :members, source: :account

  # Accounts the user owns.
  has_many :owned_accounts, class_name: "Account"
  has_many :member_requests

  # Internal analytics.
  has_many :visits, class_name: "Ahoy::Visit"
  has_many :events, class_name: "Ahoy::Event", through: :visits

  # Combination of accounts the user owns and belongs to; used heavily
  # by authorization logic to see if a user has access to an account or not.
  def accounts
    owned_accounts.union member_accounts
  end

  # TODO: Move this into a service object.
  def self.find_or_create_from_auth_hash(auth_hash)
    find_or_create_by! email: auth_hash.info.email do |user|
      user.name = auth_hash.info.name
    end
  end
end
