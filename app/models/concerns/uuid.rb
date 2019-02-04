module UUID
  extend ActiveSupport::Concern

  included do
    validates :uuid, presence: true, uniqueness: true
    before_validation :assign_default_uuid
  end

  def to_param
    uuid
  end

  private
    def assign_default_uuid
      self.uuid ||= SecureRandom.uuid
    end
end
