module Items::Templates
  class PerishablesController < BaseController
    protected
      def icons
        SvgIconFile.where key: %w[
          tag
          potted-plant
          sack-of-flour
          eggs
          tomato
          olive-oil
          champagne-bottle
          steak
          cheese
          cherry
          coffee-cup
          carrot
          lettuce
          strawberry
          banana
          tree-deciduous
          veggie-and-bottle
          chicken-leg
          aerosol-spray-can
          wine-bottle
          beer-bottle
          sprout
          radish
          wheat-beer-glass
          wine-glass
          oak-leaf
          milk-pitcher
          paint-brush
          toothpaste-tube
          deer
          closed-cardboard-box
          open-full-cardboard-box
          open-cardboard-box
          mailer
          natural-food
          orchid-flower
          toaster
          screw-top-jar
          paint-bucket
          milk-bottle
          milk-carton
          fish
        ]
      end

    private
      def assign_item_attributes
        @item.container = false
        @item.icon_key ||= "tag"
        @item.shelf_life_begin ||= "Today"
        @item.shelf_life_end ||= "6 months from now"
      end
  end
end
