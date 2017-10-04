class User < ApplicationRecord
  validates :email, presence: true
  validates :name, presence: true
  has_many :notifications
  phony_normalize :phone_number, default_country_code: 'US'
  validates :phone_number, phony_plausible: true

  # TODO: Move this into a service object.
  def self.find_or_create_from_auth_hash(auth_hash)
    find_or_create_by! email: auth_hash.info.email do |user|
      user.name = auth_hash.info.name
    end
  end
end
