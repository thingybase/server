module Items::Templates
  class ItemsController < BaseController
    protected
      def icons
        SvgAsset.where key: %w[
          object
          objects-module
          t-shirt
          womens-suite
          ska-hat
          home-office
          all-terain-vehicle
          santas-hat
          potted-plant
          sack-of-flour
          shipping-container
          scissors
          jewlery-diamond
          olive-oil
          microwave
          open-book
          lipstick
          scarf
          magic-lamp
          mortar-and-pestel
          bank-notes
          champagne-bottle
          safe
          flood-light-bulb
          television-tube
          backpack
          sneakers
          baby-in-stroller
          tickets
          coffee-cup
          packaging-box
          tag
          lawn-mower
          ink-pen
          science-project
          watering-can
          paint-brush
          mittens
          camping-tent
          tea-pot
          female-face
          male-face
          piggy-bank
          charcole-grill
          kitchen-pot
          telescope
          office-chair
          key
          snare-drum
          drum-set
          needle
          bunk-bed
          diploma
          dolly-cart
          sport-utility-vehicle
          cleaner-spray-bottle
        ]
      end

    private
      def assign_item_attributes
        @item.icon_key ||= "object"
      end
  end
end
