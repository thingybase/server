class NavigationMenuComponent < MenuComponent
  def template
    div(class: "flex md:hidden") do
      super
    end
    div(class: "hidden md:flex flex-row gap-4") do
      render @items
    end
  end
end
