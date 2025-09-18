class Views::Users::View < Views::Base
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
