# Gets a users email address, validates the format, etc.
# and figures out if the person has an account or not.
class UserResolution < ApplicationModel
  # TODO: Figure out a name for this resource...
    # UserPresence
    # UserProvision
    # UserPresence

  attr_accessor :email
  validates :email,
    presence: true,
    format: { with: URI::MailTo::EMAIL_REGEXP }

  def persisted?
    user.present?
  end

  private
    def user
      User.find_by_email(email)
    end
end
