# frozen_string_literal: true

class Views::Users::Show < Views::App
  # register_output_helper :title

  def initialize(user)
    @user = user
  end

  def title = @user.name

  def view_template
    section(class: "container-lg") do
      # title @user.name, subtitle: "Edit personal information and settings"
      #
      h1(class: "font-bold text-3xl") { title }

      div(class: "card bg-base-200") do
        div(class: "card-body") do
          h3(class: "text-xl font-bold") { "Profile" }
          p(class: "text-lg") { "How you appear in Thingybase" }

          render Components::Field::List.new @user do
            it.field :name
            it.field :email
          end

          p do
            link_to(edit_user_path(@user), class: 'btn btn-outline'){ "Edit profile" }
          end
        end
      end
    end
  end
end
