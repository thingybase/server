class ShelfFactory < ApplicationFactory
  def name
    "Shelf"
  end

  def description
    "A shelf with some stuff"
  end

  def build
    container("Shelf") do |shelf|
      3.times do |n|
        shelf.children << container("Shelf #{n}")
      end
    end
  end
end
