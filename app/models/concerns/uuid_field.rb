module UuidField
  extend ActiveSupport::Concern

  included do
    before_validation :assign_default_uuid
    validates :uuid, presence: true, uniqueness: true
  end

  private
    def assign_default_uuid
      self.uuid ||= SecureRandom.uuid
    end
end
