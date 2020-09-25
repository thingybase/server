module IconsHelper
  def icon_select_values(scope: Icon.all)
    scope.map { |icon| [ icon.name, icon.key ] }
  end
end
