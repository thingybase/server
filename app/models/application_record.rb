class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  # Persist empty strings `""` as `nil` to the database. Pretty confusing otherwise.
  nilify_blanks
end
