module IconsHelper
  def icon_select_values(scope: SvgIconFile.all)
    scope.map { |icon| [ icon.name, icon.key ] }
  end
end
