class User < ApplicationRecord
  validates :email, presence: true

  # TODO: Move this into a service object.
  def self.find_or_create_from_auth_hash(auth_hash)
    find_or_create_by! email: auth_hash.info.email
  end
end
