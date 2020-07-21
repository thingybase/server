module Accounts::Templates
  class OfficesController < BaseController
    class Template < BaseTemplate
      attr_accessor :office_supply_closet,
        :break_room_pantry,
        :storage_room

      def build
        account.name = name

        builder.container "Office supply closet", icon_key: "closet" if office_supply_closet
        builder.container "Break room snacks", icon_key: "coffee-cup" if break_room_pantry
        builder.container "Storage room", icon_key: "door-opened" if storage_room
      end
    end

    protected
      def self.resource
        Template
      end

      def assign_account_attributes
        resource.name ||= "Office"
        resource.office_supply_closet ||= true
        resource.storage_room ||= true
      end

      def permitted_params
        [
          :office_supply_closet,
          :break_room_pantry,
          :storage_room
        ]
      end
  end
end
