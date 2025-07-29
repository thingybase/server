class Components::ContactCard < Components::TitleCard
  def initialize(user:)
    @user = user
  end

  def title = @user.name
  def subtitle = "Contact Information"

  def view_template
    h1 { @user.name}
    h2 { "Contact Information" }
    dl do
      dt { "Name" }
      dd { @user.name }
      dt { "Email" }
      dd { @user.email }
    end
  end
end
