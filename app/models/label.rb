class Label < ApplicationRecord
  validates :text, presence: true
end
