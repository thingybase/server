class User < ApplicationRecord
  def self.find_or_create_from_auth_hash(auth_hash)
    find_or_create_by! email: auth_hash.info.email
  end
end
