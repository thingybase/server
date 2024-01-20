class ListCardComponent < ApplicationComponent
  include Phlex::DeferredRender

  def initialize(title, link = nil, icon: nil)
    @icon = icon
    @link = link
    @title = title
    @details = []
  end

  def detail(&content)
    @details << content
  end

  def template
    div class: "py-4 flex-col gap-2" do
      div class: "font-bold" do
        if @icon
          render IconComponent.new(@icon, class: "w-4 mr-2")
        end

        if @link
          link_to @title, @link
        else
          plain @title
        end
      end

      if @details.any?
        div class: "flex flex-row gap-2" do
          @details.each do |detail|
            span { render detail }
          end
        end
      end
    end
  end
end

__END__

.py-4.flex-col.gap-2
  .font-bold
    - if @icon
      = render IconComponent.new(@icon, class: "w-4 mr-2")
    - if @link
      = link_to @title, @link
    - else
      = @title
  .flex.flex-row.gap-2
    - if details.any?
      - details.each do |detail|
        .list-card--item--detail
          = detail.content

