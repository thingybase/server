module Views::Users
  class Edit < View
    def title = "Editing #{@user.name}"

    def view_template
      render Form.new(@user)
    end
  end
end
