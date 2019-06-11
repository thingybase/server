class HouseFactory < ApplicationFactory
  def name
    "House"
  end

  def description
    "Everything you need to create a house full of stuff"
  end

  def build
    build_container(name: "House") do |house|
      house.children << build_container(name: "Kitchen")
      house.children << build_container(name: "Garage") do |garage|
        garage.children << build_container(name: "Shelf") do |shelf|
          3.times do |n|
            shelf.children << build_container(name: "Shelf #{n}")
          end
        end
      end
    end
  end
end
