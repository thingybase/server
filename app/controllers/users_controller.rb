class UsersController < ApplicationController
  layout false

  include Superview::Actions
  include Superform::Rails::StrongParameters

  before_action do
    @user = User.find(params[:id])
    authorize @user
  end

  class View < Views::Base
    attr_writer :user

    def title = @user.name

    def around_template
      super do
        render Views::Layouts::App.new(title: @user.name) do
          section(class: "container-lg") do
            # title @user.name, subtitle: "Edit personal information and settings"
            #
            h1(class: "font-bold text-3xl") { title }

            div(class: "card bg-base-200") do
              div(class: "card-body") do
                yield
              end
            end
          end
        end
      end
    end
  end

  class Form < Components::Form
    def view_template
      row field(:name).text
      row field(:email).email

      div(class: "flex flex-row items-center gap-4"){
        submit "Save profile", class: "btn btn-primary"
        a(href: url_for(action: :show)) { "Back to profile" }
      }
    end
  end

  class Show < View
    def view_template
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

  class Edit < View
    def title = "Editing #{@user.name}"

    def view_template
      render Form.new(@user)
    end
  end

  def update
    if save Form.new(@user)
      redirect_to action: :show
    else
      render component(:edit), status: :unprocessable_entity
    end
  end
end
