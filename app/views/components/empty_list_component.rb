class EmptyListComponent < ApplicationComponent
  def view_template(&content)
    div(class: "my-24 flex flex-col gap-2", &content)
  end

  def title(&)
    h2(class: "text-xl font-bold", &)
  end

  def message(&)
    p(class: "prose", &)
  end

  def action(url, &)
    a(href: url, class: "btn btn-primary", &)
  end
end
