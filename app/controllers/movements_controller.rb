class MovementsController < ResourcesController
  include AccountLayout

  def self.resource
    Movement
  end

  protected
    def navigation_key
      "Moving"
    end

    def destroy_redirect_url
      [@movement.move, :movements]
    end
end
