# When included into an ActiveRecord, it will be linkable via its UUID column. The longer
# hex uuid formats are shortend to a  Base62 format so the URLs can be shorter.
module UuidField
  extend ActiveSupport::Concern

  # Length of GUID string, without dashes
  GUID_LENGTH = 32

  # RegExp for a long GUID
  GUID_REGEXP = /[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}/i

  included do
    before_validation :assign_default_uuid
    validates :uuid, presence: true, uniqueness: true
  end

  class_methods do
    def find_resource(short_uuid)
      uuid = UuidField.to_long_uuid short_uuid
      find_by! uuid: uuid
    end

    def find_resources(*short_uuids)
      uuids = Array(short_uuids).flatten.map { |short_uuid| UuidField.to_long_uuid short_uuid }
      where(uuid: uuids)
    end
  end

  def uid
    UuidField.to_short_uuid uuid if uuid
  end

  def to_param
    uid
  end

  private
    def assign_default_uuid
      self.uuid ||= SecureRandom.uuid
    end

    # Converts shorter `EfuYpHIrZbTTsztzBz0xHf` to longer `94409fd3b51842369aa696be0f82f045`. Note the
    # dashes are missing; turns out Postgres can deal with querying that.
    def self.to_long_uuid(short_uuid)
      pad_guid_leading_zeros Anybase::Hex.to_native Anybase::Base62.to_i short_uuid
    end

    # Converts longer `94409fd3-b518-4236-9aa6-96be0f82f045` format to shorter `EfuYpHIrZbTTsztzBz0xHf`
    def self.to_short_uuid(long_uuid)
      Anybase::Base62.to_native Anybase::Hex.to_i long_uuid.gsub("-", "")
    end

    # When Anybase converts a short UUID to a long UUID, it doesn't put leading 0's into the string
    # because it only treats it like a number, so we have to add the leading 0's back in to find the
    # uuid in Postgres.
    def self.pad_guid_leading_zeros(guid)
      guid.rjust(GUID_LENGTH,'0')
    end
end
