# When included into an ActiveRecord, it will be linkable via its UUID column.
module UuidField
  extend ActiveSupport::Concern

  included do
    before_validation :assign_default_uuid
    validates :uuid, presence: true, uniqueness: true
  end

  class_methods do
    def find_resource(uuid)
      find_by! uuid: uuid
    end
  end

  def to_param
    uuid
  end

  private
    def assign_default_uuid
      self.uuid ||= SecureRandom.uuid
    end
end
