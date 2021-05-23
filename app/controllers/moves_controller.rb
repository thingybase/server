class MovesController < ResourcesController
  include AccountLayout

  def self.resource
    Move
  end

  protected
    def navigation_key
      "Moving"
    end

    def destroy_redirect_url
      @account
    end
end
