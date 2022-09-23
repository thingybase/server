module ResourceAnalytics
  extend ActiveSupport::Concern

  included do
    after_action :track_resource, only: %i[create update]
    before_action :track_resource, only: %i[destroy]
  end

  private
    def track_resource
      ahoy.track "Resource #{action_name}",
        id: resource.id,
        model: resource.model_name.singular
    end
end
