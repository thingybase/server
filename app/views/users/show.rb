module Views::Users
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
end
