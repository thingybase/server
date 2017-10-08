class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  phony_normalize :phone_number, default_country_code: 'US'
  validates :phone_number, phony_plausible: true

  has_many :notifications

  # TODO: Move this into a service object.
  def self.find_or_create_from_auth_hash(auth_hash)
    find_or_create_by! email: auth_hash.info.email do |user|
      user.name = auth_hash.info.name
    end
  end
end
