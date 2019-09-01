class HouseFactory < ApplicationFactory
  def name
    "House"
  end

  def description
    "Everything you need to create a house full of stuff"
  end

  def build
    container("House") do |house|
      ["Master bedroom", "Bedroom 1", "Bedroom 2"].each do |room_name|
        house.children << container(room_name) do |room|
          room.children << container("Closet")
        end
      end
      house.children << container("Garage") do |garage|
        garage.children << generate(ShelfFactory).build
      end
      house.children << container("Basement") do |basement|
        basement.children << generate(ShelfFactory).build
      end
      house.children << container("Kitchen") do |kitchen|
        kitchen.children << container("Pantry")
        kitchen.children << container("Refridgerator")
      end
    end
  end

  # def save_children!
  #   build.children.each do |c|
  #     c.parent = nil
  #     c.save!
  #   end
  # end
end
