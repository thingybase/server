class MovesController < Resourcefully::ResourcesController
  include AccountLayout

  def self.resource
    Move
  end

  protected
    def permitted_params
      [:new_item_container_id]
    end

    def navigation_key
      "Moving"
    end

    def destroy_redirect_url
      @account
    end
end
