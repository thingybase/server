class PageTitleComponent < ApplicationComponent
  def initialize(title:, subtitle: nil, icon: nil)
    @title = title
    @subtitle = subtitle
    @icon = icon
  end

  def view_template
    div class: "flex flex-col" do
      h1(class: "font-semibold text-4xl flex flex-row items-center") do
        render IconComponent.new(@icon, class: "w-10 mr-3") if @icon
        plain @title
      end
      if @subtitle
        h2(class: "text-xl my-2 opacity-75") { render @subtitle }
      end
    end
  end
end
