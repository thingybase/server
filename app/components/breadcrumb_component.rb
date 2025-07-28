class Components::BreadcrumbComponent < Components::Base
  def view_template
    div(class: "breadcrumbs m-0 p-0") do
      ul do
        yield
      end
    end
  end

  def crumb(&)
    li(&)
  end
end
