module Items::Templates
  class ContainersController < BaseController
    protected
      def icons
        Icon.all keys: %w[
          folder
          open-folder
          closed-cardboard-box
          open-cardboard-box
          open-full-cardboard-box
          book-shelf
          closet
          fridge
          backpack
          chest
          safe
          paper-inbox
          room
          shipping-container
          sack-of-flour
          packaging-box
          filing-cabinet
          bankers-box
          box-of-photos
          one-pocket-folder
          two-pocket-folder
          hard-drive
          doctors-bag
          purse
          trash
          objects
        ]
      end

    private
      def assign_item_attributes
        @item.container = true
        @item.icon_key ||= "folder"
      end
  end
end
