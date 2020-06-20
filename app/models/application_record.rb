class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  # Persist empty strings `""` as `nil` to the database. Pretty confusing otherwise.
  nilify_blanks

  # Some of our controllers find resources based on a `to_param` that's not the `:id` field.
  # This method implements the behavior of finding a resource by finding it via its pk_id, and
  # controllers that need to find resources with a different ID look it by those sub-class implenentations.
  def self.find_resource(key)
    find_by! id: key
  end
end
