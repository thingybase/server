module IconsHelper
  def icon_select_values(scope: SvgAsset.all)
    scope.map { |icon| [ icon.name, icon.key ] }
  end
end
