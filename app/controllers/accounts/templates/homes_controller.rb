module Accounts::Templates
  class HomesController < BaseController
    class Template < BaseTemplate
      attr_accessor :kitchen,
        :bedrooms,
        :garage,
        :basement,
        :family_room,
        :living_room,
        :storage_room

      validates :bedrooms, numericality: { greater_than_or_equal_to: 0, only_integer: true }

      def build
        account.name = name

        bedrooms.to_i.times.each do |n|
          bedroom_name = n.zero? ? "Master bedroom" : "Bedroom #{n}"
          builder.container bedroom_name, icon_key: "empty-bed" do |bedroom|
            bedroom.container "Closet", icon_key: "closet"
          end
        end

        if kitchen
          builder.container "Kitchen", icon_key: "tableware" do |kitchen|
            kitchen.container "Refrigerator", icon_key: "fridge"
          end
        end

        if garage
          builder.container "Garage", icon_key: "garage" do |garage|
            garage.container "Shelf" do |shelf|
              shelf.container "Top shelf"
              shelf.container "Middle shelf"
              shelf.container "Bottom shelf"
            end
          end
        end

        builder.container "Family room", icon_key: "sofa-with-buttons" if family_room
        builder.container "Living room", icon_key: "livingroom-sofa" if living_room
        builder.container "Storage room" if storage_room
        builder.container "Basement" if basement
      end
    end

    def self.resource
      Template
    end

    protected
      def assign_account_attributes
        resource.name ||= "Home"
        resource.bedrooms ||= 2
        resource.kitchen ||= true
      end

      def deliver_welcome_emails
        mailer.home_welcome_email.deliver_now
        mailer.home_invite_users_email.deliver_now
      end

      def permitted_params
        [
          :name,
          :kitchen,
          :bedrooms,
          :garage,
          :basement,
          :family_room,
          :living_room,
          :storage_room
        ]
      end
  end
end
