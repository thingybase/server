module Accounts
  module Items
    class BatchesController < ::Items::BatchesController
      protected
        def navigation_key
          "Items"
        end

        def self.parent_resource
          Account
        end

        def find_account
          parent_resource
        end

        def items_scope
          parent_resource.items.roots.container_then_item
        end

        def delete_redirect_url
          account_items_url(@account)
        end
    end
  end
end
