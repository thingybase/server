module Items::Templates
  class RoomsController < BaseController
    ROOM_NAMES = [
      "Backyard",
      "Barn",
      "Basement",
      "Bathroom",
      "Bedroom",
      "Cellar",
      "Closet",
      "Den",
      "Dining room",
      "Downstairs",
      "Excercise room",
      "Family room",
      "Foyer",
      "Frontyard",
      "Game room",
      "Garage",
      "Hallway",
      "Kids room",
      "Kitchen",
      "Library",
      "Living room",
      "Master bedroom",
      "Office",
      "Pantry",
      "Playroom",
      "Shed",
      "Storage",
      "Studio",
      "Study",
      "Theater",
      "Upstairs",
      "Workshop",
    ]

    protected
      def icons
        Icon.all keys: %w[
          room
          book-shelf
          closet
          fridge
          safe
          paper-inbox
          shipping-container
          doctors-bag
          purse
          trash
          objects
          home-office
          small-business-store-front
          home
          log-cabin
          television-tube
          charcole-grill
          kitchen-pot
          bunk-bed
          empty-bed
          spin-bike
          door-opened
          small-car
          truck
          sedan
          garage
          city-buildings
          farm-field
          toilet-bowl
          paint-palette
          dog-house
          livingroom-sofa
          buffet
          easel
        ]
      end

    private
      def assign_item_attributes
        @item.container = true
        @item.icon_key ||= "room"
      end
  end
end
