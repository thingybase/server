class Views::UserMailer::Welcome < Views::Mailers::Base
  def initialize(user)
    @user = user
  end

  def view_template
    p { "Hi! #{@user.name}," }

    p { "Welcome to Thingybase!" }
  end
end
