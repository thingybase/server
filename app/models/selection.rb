# Maintains the state of a selection
class Selection < ApplicationModel
  attr_accessor :model, :selected
  delegate :id, :persisted?, :name, to: :model
end
