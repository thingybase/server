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

  def view_template
    div class: "py-4 flex-col gap-2" do
      div class: "font-semibold" do
        if @icon
          render IconComponent.new(@icon, class: "w-4 mr-2")
        end

        if @link
          link_to(@link, class: "link") { @title }
        else
          plain @title
        end
      end

      if @details.any?
        div do
          @details.each do |detail|
            span(class: "after:mx-2 after:content-['•'] last:after:content-none base-content-300") { render detail }
          end
        end
      end
    end
  end
end
