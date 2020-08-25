# Maintains the state of a selection
class Selection < ApplicationModel
  attr_accessor :model, :selected
  delegate :uid, :persisted?, :name, to: :model
end
