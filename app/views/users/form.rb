class Views::Users::Form < Components::Form
  def view_template
    row field(:name).input
    row field(:email).email
    submit "Save changes", class: "btn btn-primary"
  end
end
