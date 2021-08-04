module Labels
  class BatchesController < ApplicationController
    include LabelsHelper

    skip_after_action :verify_authorized
    after_action :verify_policy_scoped

    def show
      items = policy_scope Item.find_resources(uids)
      @labels = items.map { |item| Label.new item: item }

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
