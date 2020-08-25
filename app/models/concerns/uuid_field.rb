# When included into an ActiveRecord, it will be linkable via its UUID column. The longer hex uuid formats
# are shortend to a custom Base62 format so the URLs can be shorter.
module UuidField
  extend ActiveSupport::Concern

  # Length of GUID string, without dashes
  GUID_LENGTH = 32

  included do
    before_validation :assign_default_uuid
    validates :uuid, presence: true, uniqueness: true
  end

  class_methods do
    def find_resource(short_uuid)
      uuid = UuidField.to_long_uuid short_uuid
      find_by! uuid: uuid
    end
  end

  def to_param
    short_uuid
  end

  # Converts longer `94409fd3-b518-4236-9aa6-96be0f82f045` format to shorter `EfuYpHIrZbTTsztzBz0xHf`
  def short_uuid
    Anybase::Base62.to_native Anybase::Hex.to_i uuid.gsub("-", "")
  end

  # Converts shorter `EfuYpHIrZbTTsztzBz0xHf` to longer `94409fd3b51842369aa696be0f82f045`
  def self.to_long_uuid(short_uuid)
    pad_guid_leading_zeros Anybase::Hex.to_native Anybase::Base62.to_i short_uuid
  end

  private
    def self.pad_guid_leading_zeros(guid)
      guid.rjust(GUID_LENGTH,'0')
    end

    def assign_default_uuid
      self.uuid ||= SecureRandom.uuid
    end
end
