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

  has_many :labels
  has_many :api_keys

  def accounts
    Account
      .joins("LEFT JOIN members ON accounts.id = members.account_id")
      .where("members.user_id = ? OR accounts.user_id = ?", id, id)
      .distinct
  end

  # TODO: Move this into a service object.
  def self.find_or_create_from_auth_hash(auth_hash)
    find_or_create_by! email: auth_hash.info.email do |user|
      user.name = auth_hash.info.name
    end
  end
end
