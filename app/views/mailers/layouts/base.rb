class Views::Mailers::Layouts::Base < Views::Base
  def view_template
    html do
      body do

        yield

        p do
          div { "Cheers," }
          div { "Thingybase" }
        end
        hr
        p(class: "is-not-important-text") do
          plain "What is "
          a(href: root_url) { "Thingybase" }
          plain "? Oh nothing really, it's just a really sweet way to organize, treasure, and track your stuff."
        end
      end
    end
  end
end
