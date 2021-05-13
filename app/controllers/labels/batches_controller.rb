module Labels
  class BatchesController < ApplicationController
    include LabelsHelper

    skip_after_action :verify_authorized
    after_action :verify_policy_scoped

    def show
      @labels = policy_scope Label.find_resources(uids)

      respond_to do |format|
        format.html
        format.pdf
      end
    end

    protected
      def uids
        params.fetch(:ids).split(",")
      end
  end
end
