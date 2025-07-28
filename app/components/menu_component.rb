class Components::MenuComponent < Components::Base
  def initialize(title:)
    @title = title
    @items = []
  end

  def item(enabled: true, &item)
    @items << item if enabled
  end

  def view_template(&)
    vanish(&)

    details(class: "dropdown dropdown-end") do
      summary(class: "btn") { @title }
      ul(class: "p-2 shadow menu dropdown-content bg-base-100 rounded-box w-52 z-[1]") do
        @items.each do |item|
          li(class: "dropdown-item", &item)
        end
      end
    end
  end
end
