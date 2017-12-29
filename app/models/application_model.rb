# A model that's not backed by ActiveRecord. Used
# mostly to encapsulate AR business logic into classes
# that transition records between state. For example, when
# a user accepts an invitation, they don't do so directly to
# the `Invitation` AR model; rather its an `InvitationResponse` model.
class ApplicationModel
  include ActiveModel::Model

  # Allows form helpers to properly generate resource URLs for
  # these application models that can't be persisted because they're
  # not in the database.
  def persisted?
    false
  end
end
