module Accounts::Templates
  class BlanksController < BaseController
    class Template < BaseTemplate
      def build
        account.name = name
      end
    end

    def self.resource
      Template
    end

    private
      def permitted_params
        [:name]
      end
  end
end
