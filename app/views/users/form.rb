module Views::Users
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
end
